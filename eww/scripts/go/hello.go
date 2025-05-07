package main

import (
	"dotfiles/workspaces"
	"encoding/json"
	"fmt"
)

func main() {
    apps := ws.GetWorkspaces();

    appsJson, _ := json.Marshal(apps)
    fmt.Println(string(appsJson));
}
