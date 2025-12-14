#!/bin/bash

SELECTION="$(printf "  Lock\n  Suspend\n󰗽  Log Out\n  Reboot\n⏻  Shutdown" | fuzzel --dmenu -l 5 -p "Power Menu: ")"

case $SELECTION in
	*"Lock")
		swaylock;;
	*"Suspend")
		systemctl suspend;;
	*"Log out")
		swaymsg exit;;
	*"Reboot")
		systemctl reboot;;
	*"Shutdown")
		systemctl poweroff;;
esac
