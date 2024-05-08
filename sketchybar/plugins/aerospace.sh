#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

WORKSPACE=$1

# add a switch for sender values
case $SENDER in
  "aerospace_workspace_change")
    if [ "$WORKSPACE" = "$FOCUSED_WORKSPACE" ]; then
      # echo "sketchybar --set $NAME background.drawing=on display=$2" >> /tmp/aerospace.sh.log
      sketchybar --set "$NAME" background.drawing=on
    else
      # echo "sketchybar --set $NAME background.drawing=off display=$2" >> /tmp/aerospace.sh.log
      sketchybar --set "$NAME" background.drawing=off
    fi
    ;;
  "aerospace_refresh_workspaces")
    for mid in $(aerospace list-monitors | awk -F'|' '{print $1}'); do
      for sid in $(aerospace list-workspaces --monitor "$mid"); do
        sketchybar --set space."$sid" display="$mid"
      done
    done
    ;;
esac
