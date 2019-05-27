#!/bin/sh

# Dependencies: Light

# Usage:
# $./brightness.sh up
# $./brightness.sh down

function send_notification {
    total=`cat /sys/class/backlight/intel_backlight/brightness`
    dunstify -t 2000 -r 2594 -u normal "Brightness: $total"
}

case $1 in
    up)
        light -A 1 > /dev/null
        send_notification
        ;;
    down)
        light -U 1 > /dev/null
        send_notification
        ;;
esac
