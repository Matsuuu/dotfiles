#!/bin/sh
# Always exits 0 with "[on]" or "[off]". Defaults to "[on]" on any failure.

state="$(amixer -D pulse sget Master 2>/dev/null | awk '/Left:/{print $6; exit}')"
[ -z "$state" ] && state="[on]"
printf '%s\n' "$state"
exit 0
