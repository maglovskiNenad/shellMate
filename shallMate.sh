#!/usr/bin/env bash

# ----------------------------
# PODESAVANJE ZA LOGIN
# ----------------------------

APP_USER="$USER"
APP_PASS="1234"

# ----------------------------
# LOGIN PROZOR
# ----------------------------

show_login() {
    local login_data username password

    login_data=$(zenity --forms \
        --title="Login" \
        --text="Unesi korisnicke podatke" \
        --add-entry="Username" \
        --add-password="Password" \
        --width=350)

    #U sliucaju ako je korisnik kliknuo "cancel" ili zatvorio prozor
    if [ $? -ne 0 ]; then
        exit 0
    fi

    username=$(echo "$login_data" | cut -d '|' -f1)
    password=$(echo "$login_data" | cut -d '|' -f2)

    if [[ "$username" == "$APP_USER" && "$password" == "$APP_PASS" ]]; then
        zenity --info \
            --title="Uspesno logovanje" \
            --text="Dobrodosao, $username!"
        return 0
    else
        zenity --error \
            --title="Greska" \
            --text="Pogresan username ili password."
        return 1
    fi
}

# -----------------------------
# SYSTEM INFO
# -----------------------------
show_system_info() {
    local info

    info=$(
        echo "=== UNAME -A ==="
        uname -a
        echo
        echo "=== LLSBLK ==="
        lsblk
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
# TODO:
# - Kreiranje korisnika novog korssnika
# - Upisivanje i memorisanje podataka korisnika
# - Odredjivanje grupe pripadanja korisniku kao i njegove premise
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
app_name="shallMate"

main_menu() {
    while true;do
        choice=$(zenity --list \
        --title="Glavni meni aplikacije" \
        --text="Izaberi opciju:" \
        --radiolist \
        --column="Izaberi" \
        --column="Opcija" \
        TRUE "System info" \
        FALSE "Kreiraj korisnika" \
        FALSE "Izlaz" \
        --cancel-label="Exit" \
        --width=820 \
        --height=400 ) || break

        # U slucaju zatvaranja prozora
        if [ $? -ne 0 ]; then
            break
        fi

        case "$choice" in
            "System info")
                show_system_info
            ;;
            "Kreiraj korisnika")
                create_user_form
            ;;
            "Izlaz")
                break
                ;;
            *)
                zenity --warning --text="Nije izabrana valida opcija."
                ;;
        esac
    done


}

# -----------------------------
# GLAVNI TOK APLIKACIJE
# -----------------------------

while true; do
    if show_login; then
        main_menu
        break
    fi
done