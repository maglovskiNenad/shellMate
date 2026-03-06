#!/usr/bin/env bash

app_name="shallMate"

while true;do
    choice=$(zenity \
    --list \
    --title="$app_name" \
    --text="Izaberi opciju" \
    --cancel-label="Exit" \
    --width=520 --height=400 \
    --column="Akcija" "System info" "Disk" "Control") || break

    case "$choice" in
        "System info")
            echo "neka komanda"
        ;;
        "Disk")
            echo "neka komanda"
        ;;
        "Control")
            echo "neka komanda"
        ;;
    esac
done
