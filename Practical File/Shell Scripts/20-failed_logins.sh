#!/bin/bash

LOG_FILE="$HOME/failed_login_log.txt"

if [[ -f /var/log/auth.log ]]; then
    AUTH_LOG="/var/log/auth.log"
elif [[ -f /var/log/secure ]]; then
    AUTH_LOG="/var/log/secure"
else
    echo "$(date) - ERROR: No authentication log file found." >> "$LOG_FILE"
    exit 1
fi

FAILED_COUNT=$(grep "Failed password" "$AUTH_LOG" | wc -l)

echo "$(date) - Failed login attempts: $FAILED_COUNT" >> "$LOG_FILE"
echo "Logged failed login attempts to $LOG_FILE"
