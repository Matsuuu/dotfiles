#!/bin/bash

# Usage: ./switch_workspace_by_name.sh "Workspace Name"

name="$1"
index=$(wmctrl -d | awk -v n="$name" '$0 ~ n {print $1}')
if [ -z "$index" ]; then
  echo "Workspace '$name' not found."
  exit 1
fi
wmctrl -s "$index"
