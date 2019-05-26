#!/bin/bash

# Dependencies: Light

# Usage:
# $./brightness.sh up
# $./brightness.sh down

function send_notification {
    total=`light -G | cut -d '.' -f 1`
    bar=$(seq -s "─" $((($total + 5) / 5)) | sed 's/[0-9]//g')
    dunstify -t 5000 -r 2594 -u normal "  $bar"
}

case $1 in
    up)
        #increase brightness by 5%
        light -A 5
        send_notification
        ;;
    down)
        #decrease brightness by 5%
        light -U 5
        send_notification
        ;;
esac
