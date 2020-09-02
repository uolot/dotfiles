#!/usr/bin/env bash

if [ "$1" == "update" ] || [ "$2" == "update" ]; then
  echo "update" >/tmp/wifi.list
  notify-send "Updating wifi networks list"
  nmcli device wifi list | cut -c9- | tail -n +2 | sed -e 's/\s\s\+/#/g'  | cut -d'#' -f2 >>/tmp/wifi.list
elif [ "$1" == "list" ]; then
  cat /tmp/wifi.list
elif [ "$1" == "connect" ] && [ "$2" != "" ]; then
  notify-send "Connecting to $2"
  nmcli device wifi connect "$2"
fi

