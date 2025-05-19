#!/bin/bash

if ! command -v iostat &> /dev/null; then
    echo "iostat not found. Please install the sysstat package."
    exit 1
fi

LOG_FILE="/var/log/disk_io_monitor.log"
echo "----- $(date) -----" >> $LOG_FILE
iostat -dx 1 3 >> $LOG_FILE
echo "Disk I/O stats saved to $LOG_FILE"
