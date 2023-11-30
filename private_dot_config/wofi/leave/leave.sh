#!/usr/bin/env bash

choice=$(printf "Logout\nSuspend\nReboot\nShutdown" | wofi -dmenu)
if [[ $choice == "Logout" ]];then
    pkill -KILL -u "$USER"
elif [[ $choice == "Suspend" ]];then
    systemctl suspend
elif [[ $choice == "Reboot" ]];then
    systemctl reboot
elif [[ $choice == "Shutdown" ]];then
    systemctl poweroff
fi
