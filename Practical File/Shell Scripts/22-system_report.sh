#!/bin/bash

REPORT="/tmp/system_report.txt"
ADMIN_EMAIL="testmail@gmail.com"

{
    echo "=== System Report ==="
    echo "Date: $(date)"
    echo

    echo ">> CPU:"
    top -bn1 | grep "Cpu(s)" | awk '{print "CPU Load: " $2 "% user, " $4 "% system, " $8 "% idle"}'
    echo

    echo ">> Memory:"
    free -h | awk '/^Mem:/ {print "Used: "$3" / Total: "$2}'
    echo

    echo ">> Disk (/):"
    df -h / | awk 'NR==2 {print "Used: "$3" / Total: "$2" ("$5" used)"}'
    echo

} > "$REPORT"

mail -s "System Report" "$ADMIN_EMAIL" < "$REPORT"
