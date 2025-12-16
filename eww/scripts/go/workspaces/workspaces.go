package main

import (
	"bufio"
	"context"
	"os"
	"path/filepath"
	"strings"

	"github.com/joshuarubin/go-sway"
)

var DEFAULT_APP_ICON = ""

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

var iconCache = make(map[string]string)

type Workspace struct {
	ID      int64
	Name    string
	Focused bool
	Apps    []*App
}

type App struct {
	Name     string
	Instance string
	Icon     string
}

func getSwayClient() sway.Client {
	client, err := sway.New(context.Background())
	if err != nil {
		panic(err)
	}
	return client
}

func GetWorkspaces() []Workspace {
	var workspaces []Workspace

	client := getSwayClient()
	tree, err := client.GetTree(context.Background())
	if err != nil {
		panic(err)
	}

	walkNode(tree, nil, &workspaces)
	return workspaces
}

func walkNode(node *sway.Node, currentWorkspace *sway.Node, workspaces *[]Workspace) {
	if node == nil {
		return
	}

	// Track current workspace
	if node.Type == "workspace" {
		currentWorkspace = node
	}

	// App container
	if node.Type == "con" && currentWorkspace != nil &&
		(node.AppID != nil || node.WindowProperties != nil) {
		handleApp(node, currentWorkspace, workspaces)
	}

	for _, n := range node.Nodes {
		walkNode(n, currentWorkspace, workspaces)
	}
}

func handleApp(node *sway.Node, workspaceNode *sway.Node, workspaces *[]Workspace) {
	workspace := findWorkspaceById(workspaceNode.ID, workspaces)
	if workspace == nil {
		*workspaces = append(*workspaces, Workspace{
			ID:      workspaceNode.ID,
			Name:    workspaceNode.Name,
			Focused: workspaceNode.Focused,
		})
		workspace = &(*workspaces)[len(*workspaces)-1]
	}

	if node.Focused {
		workspace.Focused = true
	}

	inst := ""

	if node.AppID != nil {
		inst = *node.AppID
	} else if node.WindowProperties != nil {
		if node.WindowProperties.Class != "" {
			inst = node.WindowProperties.Class
		} else if node.WindowProperties.Instance != "" {
			inst = node.WindowProperties.Instance
		}
	}
	icon := determineAppIcon(inst)

	app := App{
		Name:     node.Name,
		Instance: inst,
		Icon:     icon,
	}

	workspace.Apps = append(workspace.Apps, &app)
}

func findWorkspaceById(id int64, workspaces *[]Workspace) *Workspace {
	for i := range *workspaces {
		if (*workspaces)[i].ID == id {
			return &(*workspaces)[i]
		}
	}
	return nil
}

func normalize(s string) string {
	s = strings.ToLower(s)
	s = strings.ReplaceAll(s, "-", " ")
	s = strings.ReplaceAll(s, "_", " ")
	s = strings.ReplaceAll(s, ".", " ")

	if strings.Contains(s, " ") {
		parts := strings.Fields(s)
		s = parts[len(parts)-1]
	}
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

			baseName := strings.TrimSuffix(strings.ToLower(info.Name()), ".desktop")

			matched :=
				strings.Contains(normalize(wmClassVal), instNorm) ||
					strings.Contains(normalize(execVal), instNorm) ||
					strings.Contains(normalize(nameVal), instNorm) ||
					strings.Contains(normalize(baseName), instNorm)

			if !matched || iconVal == "" {
				return nil
			}

			if strings.HasPrefix(iconVal, "/") && fileExists(iconVal) {
				absIconPath = iconVal
				return filepath.SkipDir
			}

			iconName = iconVal
			return filepath.SkipDir
		})

		if absIconPath != "" || iconName != "" {
			break
		}
	}

	if absIconPath != "" {
		iconCache[key] = absIconPath
		return absIconPath
	}

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

	result := findIconByFuzzyName(instNorm)
	if result != "" {
		iconCache[key] = result
		return result
	}

	return DEFAULT_APP_ICON
}

func findIconByFuzzyName(instNorm string) string {
	var result string

	for _, base := range POSSIBLE_ICON_PATHS {
		filepath.Walk(base, func(path string, info os.FileInfo, err error) error {
			if err != nil || info.IsDir() || result != "" {
				return nil
			}

			for _, ext := range POSSIBLE_ICON_FORMATS {
				if strings.HasSuffix(info.Name(), ext) {
					name := normalize(strings.TrimSuffix(info.Name(), ext))
					if strings.Contains(name, instNorm) {
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
