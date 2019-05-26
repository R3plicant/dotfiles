#!/bin/bash

# Dependencies: alsa-utils

# Usage:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute
# $./volume.sh mic

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_vol_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function is_mic_mute {
    amixer get Capture | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=`get_volume`
    bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
    dunstify -t 5000 -r 2593 -u normal "  $bar"
}

case $1 in
    up)
        # Set the volume on (if it was muted)
        amixer -D pulse set Master on > /dev/null
        # Raise the volume (+ 5%)
        amixer -D pulse sset Master 5%+ > /dev/null
        send_notification
        ;;
    down)
        amixer -D pulse set Master on > /dev/null
        # Lower the volume (- 5%)
        amixer -D pulse sset Master 5%- > /dev/null
        send_notification
        ;;
    mute)
    	# Toggle mute
        amixer -D pulse set Master 1+ toggle > /dev/null
        if is_vol_mute ; then
            dunstify -t 5000 -r 2593 -u normal "Audio Muted"
        else
            send_notification
        fi
        ;;
    mic)
    	# Toggle mute
        amixer -D pulse set Capture 1+ toggle > /dev/null
        if is_mic_mute ; then
            dunstify -t 5000 -r 2593 -u normal "Mic Muted"
        else
            dunstify -t 5000 -r 2593 -u normal "Mic Unmuted"
        fi
        ;;
esac
