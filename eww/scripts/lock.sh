#!/usr/bin/env bash

loginctl lock-session 

# Fallback incase the above doesn't work, like it most likely doesnt with eww
/usr/lib/kscreenlocker_greet &
