#!/usr/bin/env bash
# Outputs network status for the eww bar.
#   --stat  -> "<connection name> · <signal>%" (or "Disconnected")
#   --icon  -> absolute path to wifi/internet/no-wifi icon
#   --vpn   -> "VPN" if a tun/wg/tailscale link is up, else ""

set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
IMAGES_DIR="$SCRIPT_DIR/../images"

ICON_WIFI="$IMAGES_DIR/wifi.png"
ICON_WIRED="$IMAGES_DIR/internet.png"
ICON_NONE="$IMAGES_DIR/no-wifi.png"

# Default outputs in case anything below fails.
CONNECTION_NAME="Disconnected"
ICON="$ICON_NONE"
VPN=""

# nmcli may not be installed (or may hang during suspend); guard everything.
active="$(nmcli -t -f NAME,DEVICE,TYPE,STATE connection show --active 2>/dev/null || true)"

if [ -n "$active" ]; then
    primary=""
    while IFS= read -r line; do
        [ -z "$line" ] && continue
        name="$(printf '%s' "$line" | cut -d: -f1)"
        device="$(printf '%s' "$line" | cut -d: -f2)"
        type="$(printf '%s' "$line" | cut -d: -f3)"
        state="$(printf '%s' "$line" | cut -d: -f4)"

        [ "$state" = "activated" ] || continue

        case "$type" in
            tun|loopback|bridge|vpn|wireguard) is_vpn=1 ;;
            *) is_vpn=0 ;;
        esac

        case "$device" in
            tailscale*|docker*|br-*|veth*|wg*|lo) is_virtual=1 ;;
            *) is_virtual=0 ;;
        esac

        if [ "$is_vpn" = 1 ] || [ "$is_virtual" = 1 ]; then
            VPN="VPN"
            continue
        fi

        if [ -z "$primary" ]; then
            primary="$line"
            CONNECTION_NAME="$name"
            case "$type" in
                *wireless*|wifi) ICON="$ICON_WIFI" ;;
                *ethernet*) ICON="$ICON_WIRED" ;;
                *) ICON="$ICON_WIFI" ;;
            esac
        fi
    done <<< "$active"

    if [ -n "$primary" ]; then
        type="$(printf '%s' "$primary" | cut -d: -f3)"
        case "$type" in
            *wireless*|wifi)
                signal="$(nmcli -t -f IN-USE,SIGNAL dev wifi 2>/dev/null | awk -F: '$1=="*"{print $2; exit}')"
                if [ -n "$signal" ]; then
                    CONNECTION_NAME="$CONNECTION_NAME · ${signal}%"
                fi
                ;;
        esac
    fi
fi

case "$1" in
    --stat) printf '%s\n' "$CONNECTION_NAME" ;;
    --icon) printf '%s\n' "$ICON" ;;
    --vpn)  printf '%s\n' "$VPN" ;;
    *)      printf '%s\n' "$CONNECTION_NAME" ;;
esac

exit 0
