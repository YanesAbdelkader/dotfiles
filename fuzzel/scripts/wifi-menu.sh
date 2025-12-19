#!/usr/bin/env zsh

WIFI_STATE=$(nmcli -t -f WIFI g)

if [ "$WIFI_STATE" = "enabled" ]; then
    OPTIONS="󰤨  Connect\n󰖪 Disable Wi-Fi"
else
    OPTIONS="󰖩  Enable Wi-Fi"
fi

SELECTION=$(printf "%b" "$OPTIONS" | fuzzel --dmenu -l 5 -p "Wi-Fi:")

case "$SELECTION" in
    *"Enable Wi-Fi")
        nmcli radio wifi on
        exit
        ;;
    *"Disable Wi-Fi")
        nmcli radio wifi off
        exit
        ;;
    *"Connect")
        NETWORK=$(nmcli -t -f SSID,BARS,SECURITY d wifi list \
            | sed 's/^*/󰄬 /' \
            | fuzzel --dmenu -l 10 -p "Select network:")

        [ -z "$NETWORK" ] && exit

        SSID=$(echo "$NETWORK" | sed 's/^󰄬 //' | cut -d: -f1)
        SECURITY=$(echo "$NETWORK" | cut -d: -f3)

        if [ "$SECURITY" = "--" ] || [ -z "$SECURITY" ]; then
            nmcli dev wifi connect "$SSID"
            exit
        fi

        if nmcli -t -f NAME,TYPE connection show | grep -Fxq "$SSID:802-11-wireless"; then
            nmcli connection up "$SSID"
            exit
        fi

        PASSWORD=$(printf "" | fuzzel --dmenu -p "Password for $SSID:" --password)
        [ -z "$PASSWORD" ] && exit

        nmcli dev wifi connect "$SSID" password "$PASSWORD"
        ;;
esac
