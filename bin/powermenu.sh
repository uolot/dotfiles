#!/usr/bin/env bash

options="\
🗘 reload-config
🖼 change-wallpaper
 lock-screen
⇠ logout
 shutdown
⭮ reboot
 suspend+hibernate
 hibernate"

option=$(echo "$options" | wofi --dmenu --prompt=power | awk '{print $2}')

lock=true
powercmd=true

case "$option" in
"reload-config")
    lock=false
    powercmd="swaymsg reload"
    ;;
"change-wallpaper")
    lock=false
    powercmd="bash $HOME/Bin/sway_change_wallpaper"
    ;;
"lock-screen") ;;
"logout")
    powercmd="swaymsg exit"
    ;;
"shutdown")
    powercmd="shutdown -h now"
    ;;
"reboot")
    powercmd="systemctl reboot"
    ;;
"suspend+hibernate")
    powercmd="systemctl suspend-then-hibernate"
    ;;
"hibernate")
    powercmd="systemctl hibernate"
    ;;
*)
    lock=false
    ;;
esac

$($lock) && $HOME/Bin/sway_lock_screen
$($powercmd)
