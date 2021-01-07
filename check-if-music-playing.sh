#!/bin/sh

SONG=$(playerctl metadata title)
if [ -z "$SONG" ];then return 1; else return 0;fi
