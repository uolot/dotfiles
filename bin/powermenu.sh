#!/usr/bin/env bash

option=$(echo -e "suspend+hibernate\nhibernate\nshutdown\nreboot" | $HOME/Bin/rofi-sway -dmenu -monitor 0 -p power)

lock=true
powercmd=true

case "$option" in
    "suspend+hibernate") powercmd="systemctl suspend-then-hibernate" ;;
    "hibernate") powercmd="systemctl hibernate" ;;
    "shutdown") powercmd="shutdown -h now" ;;
    "reboot") powercmd="systemctl reboot" ;;
    *) lock=false ;;
esac

$($lock) && swaylock --daemonize --clock --indicator --screenshots --effect-blur 20x2 --effect-vignette 0.5:0.5
$($powercmd)
