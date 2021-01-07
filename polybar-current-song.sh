#!/bin/sh

BACKGROUND="#202333"
FOREGROUND="#fe7c83"

~/dotfiles/check-if-music-playing.sh
SONGSTATUS=$?

if [ "$SONGSTATUS" -eq 0 ];
then
    echo %{T2}%{F$BACKGROUND}%{T1}%{F-}%{B$BACKGROUND}%{F$FOREGROUND}  $(playerctl metadata title)  %{Btransparent}%{T2}%{F$BACKGROUND} 
fi

