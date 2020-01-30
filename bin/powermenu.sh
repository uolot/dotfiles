#!/usr/bin/env bash

option=$(echo -e "Hibernate\nShutdown\nReboot" | rofi -dmenu)

case "$option" in
    "Hibernate") systemctl suspend-then-hibernate ;;
    "Shutdown") shutdown -h now ;;
    "Reboot") systemctl reboot ;;
esac
