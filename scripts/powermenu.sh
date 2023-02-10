#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | fuzzel --dmenu -t ebdbb2ff -b 282828dd -m d65d0eff -s 665c54ff -S ebdbb2ff -C d65d0eff -x 8 --width 16 --lines 5 | awk '{print tolower($2)}' )

case $op in 
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $op
                ;;
        lock)
		swaylock
                ;;
        logout)
                swaymsg exit
                ;;
esac
