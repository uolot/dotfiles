#!/usr/bin/env bash

option=$(echo -e "Suspend+Hibernate\nHibernate\nShutdown\nReboot" | rofi -dmenu)

case "$option" in
    "Suspend+Hibernate") systemctl suspend-then-hibernate ;;
    "Hibernate") systemctl hibernate ;;
    "Shutdown") shutdown -h now ;;
    "Reboot") systemctl reboot ;;
esac
