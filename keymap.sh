#!/bin/sh

lang=$(setxkbmap -query | grep layout | cut -d ':' -f 2 | tr -d ' ')

if [[ $lang == "ru" ]]
then
    setxkbmap us
    dunstify -t 2000 -r 2595 -u normal 'Current Keyboard Layout:' 'US (English)'
else
    setxkbmap ru
    dunstify -t 2000 -r 2595 -u normal 'Current Keyboard Layout:' 'RU (Russian)'
fi
