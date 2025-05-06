#!/bin/sh

# Get the name of the currently active connection using nmcli
active_connection=$(nmcli -t -f NAME,DEVICE,TYPE,STATE connection show --active | head -n1)
device_type=$(echo "$active_connection" | cut -d: -f3)
connection_state=$(echo "$active_connection" | cut -d: -f4)

# Parse out connection name, device type, and state
if [[ "$connection_state" == "activated" ]]; then
    CONNECTION_NAME=$(echo "$active_connection" | cut -d: -f1)

    if [[ "$device_type" == "wifi" ]]; then
	    ICON="images/wifi.png"
    fi

    if [[ "$device_type" == *"wireless" ]]; then
	    ICON="images/wifi.png"
    fi

    if [[ "$device_type" == *"ethernet" ]]; then
	    ICON="images/internet.png"
    fi
else
    CONNECTION_NAME="Disconnected"
    ICON="images/no-wifi.png"
fi

case "$1" in
    --stat) echo "$CONNECTION_NAME" ;;
    --icon) echo "$ICON" ;;
esac
