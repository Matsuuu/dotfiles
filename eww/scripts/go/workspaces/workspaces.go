package main

import (
	"bufio"
	"os"
	"path/filepath"
	"strings"

	"go.i3wm.org/i3/v4"
)

var DEFAULT_APP_ICON = "" // set a fallback icon path if you want

var DESKTOP_PATHS = []string{
	"/usr/share/applications/",
	"/usr/local/share/applications/",
	os.Getenv("HOME") + "/.local/share/applications/",
	os.Getenv("HOME") + "/.local/share/flatpak/exports/share/applications/",
	"/var/lib/flatpak/exports/share/applications/",
}

var POSSIBLE_ICON_PATHS = []string{
	"/usr/share/icons/hicolor/scalable/apps/",
	"/usr/share/icons/hicolor/256x256/apps/",
	"/usr/share/icons/hicolor/128x128/apps/",
	"/usr/share/pixmaps/",
	os.Getenv("HOME") + "/.local/share/icons/hicolor/scalable/apps/",
	os.Getenv("HOME") + "/.local/share/icons/hicolor/128x128/apps/",
	os.Getenv("HOME") + "/.local/share/flatpak/exports/share/icons/hicolor/scalable/apps/",
	os.Getenv("HOME") + "/.local/share/flatpak/exports/share/icons/hicolor/256x256/apps/",
	"/var/lib/flatpak/exports/share/icons/hicolor/scalable/apps/",
	"/var/lib/flatpak/exports/share/icons/hicolor/256x256/apps/",
}

var POSSIBLE_ICON_FORMATS = []string{
	".svg",
	".png",
}

// Cache for successful icon resolutions (keyed by lowercased instance/class)
var iconCache = make(map[string]string)

type Workspace struct {
	ID      i3.NodeID
	Number  int
	Name    string
	Focused bool
	Apps    []*App
}

type App struct {
	Name     string
	Instance string
	Icon     string
}

func GetWorkspaces() []Workspace {
	var workspaces []Workspace

	tree, err := i3.GetTree()
	if err != nil {
		panic("Could not parse tree")
	}

	walkChildren(tree.Root, &workspaces)
	return workspaces
}

func walkChildren(node *i3.Node, workspaces *[]Workspace) {
	for _, node := range node.Nodes {
		walkNode(node, workspaces)
	}
}

func walkNode(node *i3.Node, workspaces *[]Workspace) {
	switch node.Type {
	case i3.Con:
		handleApp(node, workspaces)
	default:
		walkChildren(node, workspaces)
	}
}

func handleApp(node *i3.Node, workspaces *[]Workspace) {
	if node.WindowType == "" {
		walkChildren(node, workspaces)
		return
	}
	if node.WindowType != "normal" {
		return
	}

	workspaceNode := findAppWorkspace(node)
	if workspaceNode.Type == i3.Root {
		return
	}

	workspace := findWorkspaceById(workspaceNode.ID, workspaces)
	if workspace == nil {
		*workspaces = append(*workspaces, Workspace{
			ID:      workspaceNode.ID,
			Name:    workspaceNode.Name,
			Focused: node.Focused,
		})
		workspace = &(*workspaces)[len(*workspaces)-1]
	}

	if node.Focused {
		workspace.Focused = true
	}

	inst := node.WindowProperties.Instance
	class := node.WindowProperties.Class

	// Try instance first, then class (so WM_CLASS=Google-chrome works)
	icon := determineAppIcon(inst)
	if icon == DEFAULT_APP_ICON && class != "" {
		icon = determineAppIcon(class)
	}

	app := App{
		Name:     node.Name,
		Instance: inst + "/" + class,
		Icon:     icon,
	}

	workspace.Apps = append(workspace.Apps, &app)
}

func findAppWorkspace(node *i3.Node) *i3.Node {
	parent := node.FindParent()
	for parent != nil && parent.Type != i3.WorkspaceNode && parent.Type != i3.Root {
		parent = parent.FindParent()
	}
	return parent
}

func findWorkspaceById(id i3.NodeID, workspaces *[]Workspace) *Workspace {
	for i, workspace := range *workspaces {
		if workspace.ID == id {
			return &(*workspaces)[i]
		}
	}
	return nil
}

// normalize makes matching more forgiving: handles Google Chrome, jetbrains-rider, etc.
// It is used only for TEXT comparisons, not for actual icon filenames.
func normalize(s string) string {
	s = strings.ToLower(s)
	s = strings.ReplaceAll(s, "-", " ")
	s = strings.ReplaceAll(s, "_", " ")
	s = strings.ReplaceAll(s, ".", " ")
	return s
}

func fileExists(path string) bool {
	_, err := os.Stat(path)
	return err == nil
}

func determineAppIcon(instance string) string {
	if instance == "" {
		return DEFAULT_APP_ICON
	}

	key := strings.ToLower(instance)
	if cached, ok := iconCache[key]; ok {
		return cached
	}

	instNorm := normalize(instance)
	var iconName string
	var absIconPath string

	// 1) Scan .desktop entries and try to match instance against Name/Exec/StartupWMClass/file name
	for _, dir := range DESKTOP_PATHS {
		filepath.Walk(dir, func(path string, info os.FileInfo, err error) error {
			if err != nil || info.IsDir() || !strings.HasSuffix(info.Name(), ".desktop") {
				return nil
			}

			f, err := os.Open(path)
			if err != nil {
				return nil
			}
			defer f.Close()

			scanner := bufio.NewScanner(f)

			var nameVal, execVal, wmClassVal, iconVal string

			for scanner.Scan() {
				line := scanner.Text()
				lower := strings.ToLower(line)

				switch {
				case strings.HasPrefix(lower, "name="):
					nameVal = strings.TrimSpace(line[5:])
				case strings.HasPrefix(lower, "exec="):
					execVal = strings.TrimSpace(line[5:])
				case strings.HasPrefix(lower, "startupwmclass="):
					wmClassVal = strings.TrimSpace(line[len("StartupWMClass="):])
				case strings.HasPrefix(lower, "icon="):
					iconVal = strings.TrimSpace(line[5:])
				}
			}

			if iconVal == "" && wmClassVal == "" && nameVal == "" && execVal == "" {
				return nil
			}

			baseName := strings.TrimSuffix(strings.ToLower(info.Name()), ".desktop")

			wmClassNorm := normalize(wmClassVal)
			execNorm := normalize(execVal)
			nameNorm := normalize(nameVal)
			baseNorm := normalize(baseName)

			matched := false

			// Strongest: exact WM_CLASS match (case-insensitive)
			if strings.EqualFold(wmClassVal, instance) {
				matched = true
			}
			// Normalized WM_CLASS match (handles Google-chrome vs google chrome)
			if !matched && wmClassNorm == instNorm {
				matched = true
			}
			// Exec contains instance
			if !matched && strings.Contains(execNorm, instNorm) {
				matched = true
			}
			// Name contains instance
			if !matched && strings.Contains(nameNorm, instNorm) {
				matched = true
			}
			// Desktop filename contains instance
			if !matched && strings.Contains(baseNorm, instNorm) {
				matched = true
			}

			if !matched || iconVal == "" {
				return nil
			}

			// Absolute icon path
			if strings.HasPrefix(iconVal, "/") && fileExists(iconVal) {
				absIconPath = iconVal
				return filepath.SkipDir
			}

			// Otherwise it's an icon name (com.google.Chrome, firefox, etc.)
			if iconName == "" {
				iconName = iconVal
			}
			return filepath.SkipDir
		})

		if absIconPath != "" || iconName != "" {
			break
		}
	}

	// 2) If we got an absolute icon path from a .desktop → done
	if absIconPath != "" {
		iconCache[key] = absIconPath
		return absIconPath
	}

	// 3) If we got an icon name from a .desktop → resolve it in icon dirs
	if iconName != "" {
		for _, base := range POSSIBLE_ICON_PATHS {
			for _, ext := range POSSIBLE_ICON_FORMATS {
				p := base + iconName + ext
				if fileExists(p) {
					iconCache[key] = p
					return p
				}
			}
		}
	}

	// 4) Last-resort fuzzy search: scan icon dirs directly by filename substring
	//    This will match instance "chrome" to com.google.Chrome.svg, etc.
	fuzzy := findIconByFuzzyName(instNorm)
	if fuzzy != "" {
		iconCache[key] = fuzzy
		return fuzzy
	}

	// 5) Fallback
	return DEFAULT_APP_ICON
}

// findIconByFuzzyName tries to locate an icon where the normalized filename
// contains the normalized instance (e.g. "chrome" in "com.google.Chrome").
func findIconByFuzzyName(instNorm string) string {
	if instNorm == "" {
		return ""
	}

	for _, base := range POSSIBLE_ICON_PATHS {
		filepath.Walk(base, func(path string, info os.FileInfo, err error) error {
			if err != nil || info.IsDir() {
				return nil
			}

			name := info.Name()
			for _, ext := range POSSIBLE_ICON_FORMATS {
				if strings.HasSuffix(name, ext) {
					baseName := strings.TrimSuffix(name, ext)
					baseNorm := normalize(baseName)
					if strings.Contains(baseNorm, instNorm) {
						// We don't need extra fileExists; Walk already saw it.
						// Just return by stopping traversal.
						// Note: we can't break Walk from here without SkipDir,
						// so we store in a closure variable and rely on that.
						// But since we're in a helper, simplest is:
						// just return filepath.SkipDir to bail out of this subtree.
						return filepath.SkipDir
					}
				}
			}
			return nil
		})

		// We can't directly get the chosen path from inside the closure unless we
		// capture it; let's do that properly instead.
	}

	// More robust version with captured result:
	var result string
	for _, base := range POSSIBLE_ICON_PATHS {
		filepath.Walk(base, func(path string, info os.FileInfo, err error) error {
			if err != nil || info.IsDir() || result != "" {
				return nil
			}

			name := info.Name()
			for _, ext := range POSSIBLE_ICON_FORMATS {
				if strings.HasSuffix(name, ext) {
					baseName := strings.TrimSuffix(name, ext)
					baseNorm := normalize(baseName)
					if strings.Contains(baseNorm, instNorm) {
						result = path
						return filepath.SkipDir
					}
				}
			}
			return nil
		})
		if result != "" {
			break
		}
	}

	return result
}
