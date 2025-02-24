#!/bin/bash

log_file="/var/log/auth.log"  # Default log file
btmp_file="/var/log/btmp"  # Bad login attempts log file
OUTPUT_DIR="output-v1"  # Directory to store output

# Ensure the output directory exists
if [ ! -d "$OUTPUT_DIR" ]; then
  mkdir -p "$OUTPUT_DIR"
fi

# Get current timestamp for unique output filename
TIMESTAMP=$(date +'%Y%m%d_%H%M%S')

# Define the output file path
OUTPUT_FILE="$OUTPUT_DIR/log_output_$TIMESTAMP.txt"

# Function to append output to the log file
log_output() {
    echo "$1" >> "$OUTPUT_FILE"
}

display_last_login_logout() {
    result=$(last -a | head -10)
    echo "$result"
    log_output "$result"
}

display_bad_logins() {
    if [[ -r "$btmp_file" ]]; then
        result=$(lastb | head -10)
        echo "$result"
        log_output "$result"
    else
        result="Cannot read $btmp_file. Try running as root."
        echo "$result"
        log_output "$result"
    fi
}

display_current_user() {
    result=$(whoami)
    echo -e "\n$result"
    log_output "$result"
}

display_uptime() {
    result=$(uptime -p)
    echo -e "\n$result"
    log_output "$result"
}

display_last_reboot() {
    result=$(last reboot | head -1)
    echo "$result"
    log_output "$result"
}

# Function to search keyword within log files
process_log_file() {
    result="Filtering logs for: $1"
    echo "$result"
    log_output "$result"
    result=$(grep "$1" "$log_file" | less)
    echo "$result"
    log_output "$result"
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
               log_output "Exited the program successfully!"
               exit 0 ;;
            *) echo "Invalid choice, please try again." ;;
        esac
    done
}

# Running the main function
menu
