#!/bin/bash

# Define log file paths
log_file="/var/log/auth.log"         # Default log file
btmp_file="/var/log/btmp"            # Bad login attempts log file
syslog_file="/var/log/syslog"        # System log
kernlog_file="/var/log/kern.log"     # Kernel log
dmesg_file="/var/log/dmesg"          # dmesg log
messages_file="/var/log/messages"    # System messages log
cron_file="/var/log/cron"            # Cron log
dpkg_file="/var/log/dpkg.log"        # dpkg log
ufw_file="/var/log/ufw.log"          # UFW log

OUTPUT_DIR="output-v2"               

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

# Function to display last login and logout
display_last_login_logout() {
    title="Last Login and Logout"
    result=$(last -a | head -10)
    echo "$title"
    echo "$result"
    log_output "$title"
    log_output "$result"
}

# Function to display bad login attempts
display_bad_logins() {
    title="Bad Login Attempts"
    if [[ -r "$btmp_file" ]]; then
        result=$(lastb | head -10)
    else
        result="Cannot read $btmp_file. Try running as root."
    fi
    echo "$title"
    echo "$result"
    log_output "$title"
    log_output "$result"
}

# Function to display current user
display_current_user() {
    title="Current User"
    result=$(whoami)
    echo "$title"
    echo "$result"
    log_output "$title"
    log_output "$result"
}

# Function to display uptime of machine
display_uptime() {
    title="Uptime of Machine"
    result=$(uptime -p)
    echo "$title"
    echo "$result"
    log_output "$title"
    log_output "$result"
}

# Function to display last reboot status
display_last_reboot() {
    title="Last Reboot and its Status"
    result=$(last reboot | head -1)
    echo "$title"
    echo "$result"
    log_output "$title"
    log_output "$result"
}

# Function to search keyword within log files
process_log_file() {
    title="Filtering logs for: $1"
    result="Results: $(grep "$1" "$log_file" | less)"
    echo "$title"
    echo "$result"
    log_output "$title"
    log_output "$result"
}

# Function to display the contents of each log file
display_log_file() {
    title="$1"
    file="$2"

    # Check if the file exists and is readable
    if [[ -r "$file" ]]; then
        result=$(head -10 "$file") # Show the first 10 lines
    else
        result="Cannot read $file. File may not exist or be unreadable."
    fi

    echo "$title"
    echo "$result"
    log_output "$title"
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
        echo "7. Display System Log (syslog)"
        echo "8. Display Kernel Log (kern.log)"
        echo "9. Display dmesg Log"
        echo "10. Display System Messages (messages)"
        echo "11. Display Cron Log"
        echo "12. Display dpkg Log"
        echo "13. Display UFW Log"
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
            7) display_log_file "System Log (syslog)" "$syslog_file" ;;
            8) display_log_file "Kernel Log (kern.log)" "$kernlog_file" ;;
            9) display_log_file "dmesg Log" "$dmesg_file" ;;
            10) display_log_file "System Messages (messages)" "$messages_file" ;;
            11) display_log_file "Cron Log" "$cron_file" ;;
            12) display_log_file "dpkg Log" "$dpkg_file" ;;
            13) display_log_file "UFW Log" "$ufw_file" ;;
            0) echo -e "\nExited the program successfully!"
               log_output "Exited the program successfully!"
               exit 0 ;;
            *) echo "Invalid choice, please try again." ;;
        esac
    done
}

# Running the main function
menu
