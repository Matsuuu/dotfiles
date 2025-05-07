package main

import (
	"go.i3wm.org/i3/v4"
)

type Workspace struct {
    ID      i3.NodeID
    Name    string
    Apps    []*App
}

type App struct {
    Name    string
    Instance    string
    Icon    string
}

func GetWorkspaces() []Workspace {
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
    workspace := findWorkspaceById(workspaceNode.ID, workspaces)
    if workspace == nil {
        *workspaces = append(*workspaces, Workspace{
            ID: workspaceNode.ID,
            Name: workspaceNode.Name,
        })
        workspace = &(*workspaces)[len(*workspaces)-1]
    }
    
    app := App{
        Name: node.Name,
        Instance: node.WindowProperties.Instance,
        Icon: "/usr/share/applications/" + node.WindowProperties.Instance + ".desktop",
    }

    workspace.Apps = append(workspace.Apps, &app)
}

func findAppWorkspace(node *i3.Node) *i3.Node {
    parent := node.FindParent()
    for parent.Type != i3.WorkspaceNode || parent == nil {
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
