#!/bin/sh

i3-msg -t get_workspaces | jq -c '[.[] | {num: .num, focused: .focused}]'
