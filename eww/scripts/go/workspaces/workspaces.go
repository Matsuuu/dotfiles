package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"go.i3wm.org/i3/v4"
)

var DEFAULT_APP_ICON = ""
var POSSIBLE_ICON_PATHS = []string{
    "/usr/share/icons/hicolor/256x256/apps/",
    "/usr/share/icons/hicolor/128x128/apps/",
    "/usr/share/pixmaps/",
    "/usr/share/icons/hicolor/scalable/apps/",
}
var POSSIBLE_ICON_FORMATS = []string{
    ".png",
    ".svg",
}

type Workspace struct {
    ID          i3.NodeID
    Number      int
    Name        string
    Focused     bool
    Apps        []*App
}

type App struct {
    Name        string
    Instance    string
    Icon        string
}

func GetWorkspaces() []Workspace {
    fmt.Println("")
    var workspaces []Workspace

    tree, err := i3.GetTree()
    if (err != nil) {
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
            break;
        default:
            walkChildren(node, workspaces)
	}
}

func handleApp(node *i3.Node, workspaces *[]Workspace) {
    if (node.WindowType == "") {
        walkChildren(node, workspaces);
        return
    }
    if (node.WindowType != "normal") {
        return 
    }

    workspaceNode := findAppWorkspace(node)

    if workspaceNode.Type == i3.Root {
        return;
    }

    workspace := findWorkspaceById(workspaceNode.ID, workspaces)
    if workspace == nil {
        *workspaces = append(*workspaces, Workspace{
            ID: workspaceNode.ID,
            Name: workspaceNode.Name,
            Focused: node.Focused,
        })
        workspace = &(*workspaces)[len(*workspaces)-1]
    }

    if (node.Focused) {
        workspace.Focused = true
    }
    
    app := App{
        Name: node.Name,
        Instance: node.WindowProperties.Instance,
        Icon: determineAppIcon(node.WindowProperties.Instance),
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
        if (workspace.ID == id) {
            return &(*workspaces)[i]
        }
    }
    return nil
}

func determineAppIcon(instance string) string {
    iconPath := DEFAULT_APP_ICON
    dir := "/usr/share/applications/"

    var icon string

    filepath.Walk(dir, func(path string, info os.FileInfo, err error) error {
        if err != nil || info.IsDir() || !strings.HasSuffix(info.Name(), ".desktop") {
            return nil
        }

        file, err := os.Open(path)
        if err != nil {
            return nil
        }
        defer file.Close()

        scanner := bufio.NewScanner(file)
        match := false

        for scanner.Scan() {
            line := scanner.Text()

            if strings.HasPrefix(line, "StartupWMClass=") && strings.Contains(strings.ToLower(line), strings.ToLower(instance)) {
                match = true
            }
            if strings.HasPrefix(line, "Exec=") && strings.Contains(strings.ToLower(line), strings.ToLower(instance)) {
                match = true
            }
            if strings.HasPrefix(line, "Icon=") {
                icon = strings.TrimPrefix(line, "Icon=")
            }
        }

        if match {
            return filepath.SkipDir // stop searching
        }

        return nil
    })

    // Test against known icon directories and file extensions
    for _, path := range POSSIBLE_ICON_PATHS {
        for _, ext := range POSSIBLE_ICON_FORMATS {
            filePath := path + icon + ext

            if _, err := os.Stat(filePath); err == nil {
                iconPath = filePath
                break;
            }
        }
        if iconPath != "" {
            break;
        }
    }

    return iconPath
}
