#!/bin/bash

# Usage: ./switch_workspace_by_name.sh "workspace-name-or-number"

name="$1"

if [ -z "$name" ]; then
  exit 1
fi

swaymsg workspace "$name" >/dev/null

