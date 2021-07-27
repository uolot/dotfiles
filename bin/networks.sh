#!/usr/bin/env bash

one_hour=3600

if [ "$1" == "update" ] || [ "$2" == "update" ]; then
  echo "Updating wifi networks list"
  notify-send "Updating wifi networks list"
  echo "update" >/tmp/wifi.list
  echo "reset" >/tmp/wifi.list
  nmcli device wifi list --rescan yes | cut -c9- | tail -n +2 | sed -e 's/\s\s\+/#/g' | cut -d'#' -f2 >>/tmp/wifi.list
elif [ "$1" == "list" ]; then
  list_age=$(($(date +%s) - $(date +%s -r /tmp/wifi.list)))
  if ((($list_age) > ($one_hour))); then
    $0 update
  fi
  cat /tmp/wifi.list
elif [ "$1" == "connect" ] && [ "$2" != "" ]; then
  notify-send "Connecting to $2"
  nmcli device wifi connect "$2"
elif [ "$1" == "reset" ]; then
  conn=$(nmcli connection show --active | awk '! /NAME/ && ! /bridge/ {print $1}')
  nmcli connection down "$conn"
  nmcli connection up "$conn"
fi
