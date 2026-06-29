#!/bin/sh
# Always exits 0 with a JSON array. Empty on failure.

out="$(i3-msg -t get_workspaces 2>/dev/null | jq -c '[.[] | {num: .num, focused: .focused}]' 2>/dev/null)"
[ -z "$out" ] && out="[]"
printf '%s\n' "$out"
exit 0
