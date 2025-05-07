package main

import (
	"encoding/json"
	"fmt"
)

func main() {
    apps := GetWorkspaces();

    appsJson, _ := json.Marshal(apps)
    fmt.Println(string(appsJson));
}
