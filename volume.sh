#!/bin/sh

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
    dunstify -t 2000 -r 2593 -u normal "Volume: $volume"
}

case $1 in
    up)
        # Set the volume on (if it was muted)
        amixer set Master on > /dev/null
        # Raise the volume (+ 5%)
        amixer set Master 1%+ > /dev/null
        send_notification
        ;;
    down)
        amixer set Master on > /dev/null
        # Lower the volume (- 5%)
        amixer set Master 1%- > /dev/null
        send_notification
        ;;
    mute)
        # Toggle mute
        amixer set Master 1+ toggle > /dev/null
        if is_vol_mute
        then
            dunstify -t 2000 -r 2593 -u normal "Audio Muted"
        else
            send_notification
        fi
        ;;
    mic)
        # Toggle mute
        amixer set Capture 1+ toggle > /dev/null
        if is_mic_mute
        then
            dunstify -t 2000 -r 2592 -u normal "Mic Muted"
        else
            dunstify -t 2000 -r 2592 -u normal "Mic Unmuted"
        fi
        ;;
esac
