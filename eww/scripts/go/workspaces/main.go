package main

import (
	"encoding/json"
	"fmt"
	"os"
)

func main() {
	if os.Getenv("SWAYSOCK") != "" && os.Getenv("I3SOCK") == "" {
		os.Setenv("I3SOCK", os.Getenv("SWAYSOCK"))
	}

	apps := GetWorkspaces()

	appsJson, _ := json.Marshal(apps)
	fmt.Println(string(appsJson))
}
