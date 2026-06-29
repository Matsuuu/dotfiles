#!/bin/sh
# Always exits 0 with a numeric volume (0-100). Empty/failure falls back to 0.

vol=""

if command -v pamixer >/dev/null 2>&1; then
    if [ "$(pamixer --get-mute 2>/dev/null)" = "true" ]; then
        vol=0
    else
        vol="$(pamixer --get-volume 2>/dev/null)"
    fi
fi

if [ -z "$vol" ]; then
    vol="$(amixer -D pulse sget Master 2>/dev/null | awk -F '[^0-9]+' '/Left:/{print $3; exit}')"
fi

[ -z "$vol" ] && vol=0
printf '%s\n' "$vol"
exit 0
