#!/bin/bash
# prompt that will ask to cancle, or power off the system

ans=$(echo -e "cancel\nshutdown" | rofi -dmenu -format i:s)

case "${ans:0:1}" in
    0) exit;;
    1) /usr/bin/numlockx off; systemctl poweroff;;
esac