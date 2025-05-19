#!/bin/bash

threshold=80
logfile="/var/log/cpu_temp.log"

if ! command -v sensors &> /dev/null
then
    echo "sensors command could not be found. Please install lm-sensors."
    exit 1
fi

cpu_temp=$(sensors | grep 'Core 0' | awk '{print $3}' | tr -d '+C')  # Remove "+" and "C”

if [ -z "$cpu_temp" ]; then
    echo "Could not retrieve CPU temperature. Ensure sensors are supported on your system."
    exit 1
fi

timestamp=$(date +"%Y-%m-%d %H:%M:%S")
echo "$timestamp - CPU Temperature: $cpu_temp C" >> "$logfile"

if [ "$cpu_temp" -ge "$threshold" ]; then
    echo "Warning: CPU temperature has exceeded the threshold of $threshold C. Current temperature: $cpu_temp C"
fi
