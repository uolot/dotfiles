#!/bin/sh

# Source: https://github.com/user18130814200115-2/swayscrips/tree/main/advancedmove

swaymsg mark "__swap__", focus $1
focus=$(swaymsg -t get_tree | grep -A2 '__swap__' | grep -o 'focused\": true')

if [ "$focus" = "focused\": true" ]
then
	swaymsg move $1
else
	swaymsg swap container with mark "__swap__", focus $1, unmark "__swap__";
fi
