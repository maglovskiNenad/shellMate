#!/usr/bin/env bash

# -----------------------------
# SYSTEM INFO
# -----------------------------
show_system_info() {
    local info

    info=$(
        echo "=== SYSTEM INFORMATION ==="
        hostnamectl 
        echo
        echo "=== LIST BLOCK DEVICES ==="
        lsblk
        echo 
        echo "=== REPORT FILE SYSTEM SPACE USAGE ==="
        df -h
    )

    zenity --text-info \
        --title="System info" \
        --width=800 \
        --height=500 \
        --filename=<(echo "$info")
}

# -----------------------------
# KREIRANJE KORISNIKA 
# -----------------------------
create_user_form(){
    local user_data new_user full_name shell_choice

    user_data=$( zenity --forms \
    --title="Kreiranje korisnika" \
    --text="Unesi podatke za  ovog korisnika" \
    --add-entry="Username" \
    --add-entry="Full Name" \
    --add-combo="Shell" \
    --combo-values="/bin/bash|/bin/sh|/usr/sbin/nologin" \
    --width=400)

    if [ $? -ne 0]; then
        return
    fi

    new_user=$(echo "$user_data" | cut -d '|' -f1)
    full_name=$(echo "$user_data" | cut -d '|' -f2)
    shell_choice=$(echo "$user_data" | cut -d '|' -f3)

    zenity --info \
        --title="Test akcija" \
        --text="Ovde bi islo kreranje korisnika:\n\nUsername: $user_name\nFull Name: $full_name\nShell: $shell_choice"

    # kad se bude kreirao user bice neophodno:
    # sudo useradd -m -c "$full_name" -s "$shell_choice" "$new_user"
}
# -----------------------------
# GLAVNI MENI
# -----------------------------

main_menu() {
    choice=$(zenity --list \
        --title="shallMate" \
        --width=700 \
        --height=500 \
        --column="Options" \
        "System info" \
        "Status" \
        "Disk" \
        --ok-label="Ok" \
        --cancel-label="Exit" \
        )
    
    # U slucaju zatvaranja prozora
    if [ $? -ne 0 ]; then
        exit 0
    fi

    case "$choice" in
        "System info")
            show_system_info
            ;;
        "Users")
            create_user_form
            ;;
        "Izlaz")
            exit 0
            ;;
    esac
}

# -----------------------------
# GLAVNI TOK APLIKACIJE
# -----------------------------

while true; do
    main_menu
done