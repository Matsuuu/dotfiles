#!/bin/sh

UPDATE_COUNT=$(pacman -Qu | wc | awk '{print $1}')
if [[ $UPDATE_COUNT -lt 1 ]]; then
    echo "No updates"
else
    echo $UPDATE_COUNT Updates available
fi
