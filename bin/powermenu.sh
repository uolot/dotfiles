#!/usr/bin/env bash

option=$(echo -e "Suspend+Hibernate\nHibernate\nShutdown\nReboot" | rofi -dmenu)

lock=true
powercmd=true

case "$option" in
    "Suspend+Hibernate") powercmd="systemctl suspend-then-hibernate" ;;
    "Hibernate") powercmd="systemctl hibernate" ;;
    "Shutdown") powercmd="shutdown -h now" ;;
    "Reboot") powercmd="systemctl reboot" ;;
    *) lock=false ;;
esac

$($lock) && swaylock --daemonize --clock --indicator --screenshots --effect-blur 20x2 --effect-vignette 0.5:0.5
$($powercmd)
