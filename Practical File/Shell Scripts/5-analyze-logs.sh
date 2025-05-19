#!/bin/bash

log_file="/var/log/auth.log"  # Default log file
btmp_file="/var/log/btmp"     # Bad login attempts log file

display_last_login_logout() {
    last -a | head -10
}

display_bad_logins() {
    if [[ -r "$btmp_file" ]]; then
        lastb | head -10
    else
        echo "Cannot read $btmp_file. Try running as root."
    fi
}

display_current_user() {
    whoami
}

display_uptime() {
    uptime -p
}

display_last_reboot() {
    last reboot | head -1
}

# Function to search keyword within log files
process_log_file() {
    echo "Filtering logs for: $1"
    grep "$1" "$log_file" | less
}

menu() {
    while true; do
        echo -e "\nChoose an option:"
        echo "1. Last Login and Logout"
        echo "2. Bad Login Attempts"
        echo "3. Current User"
        echo "4. Uptime of Machine"
        echo "5. Last Reboot and its Status"
        echo "6. Search Keyword in Log Files"
        echo "0. Exit"
        read -p "Enter your choice: " choice
        case $choice in
            1) display_last_login_logout ;;
            2) display_bad_logins ;;
            3) display_current_user ;;
            4) display_uptime ;;
            5) display_last_reboot ;;
            6) read -p "Enter search keyword: " keyword
               process_log_file "$keyword" ;;
            0) echo -e "\nExited the program successfully!"
               exit 0 ;;
            *) echo "Invalid choice, please try again." ;;
        esac
    done
}

# Running the main function
menu
