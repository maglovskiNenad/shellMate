#!/usr/bin/env bash

# -----------------------------
# SHOW_INFO
# -----------------------------

show_info() {
    local title="$1"
    shift
    local content


    content=$("$@")

    zenity --text-info \
        --title="$title" \
        --width=800 \
        --height=500 \
        --filename=<(echo "$content")
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
        "Information" \
        "System info" \
        "Disk" \
        --ok-label="Ok" \
        --cancel-label="Exit" \
        )
    
    # U slucaju zatvaranja prozora
    if [ $? -ne 0 ]; then
        exit 0
    fi

    case "$choice" in
        "Information")
            show_info "Information" hostnamectl
            ;;
        "System info")
            show_info "System info" systemctl status
            ;;
        "Disk")
            show_info "Disk" df -h
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