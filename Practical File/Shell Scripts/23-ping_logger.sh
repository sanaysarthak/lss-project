#!/bin/bash

HOST=8.8.8.8
LOGFILE="/tmp/network_log.txt"

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    if ping -c1 -W2 "$HOST" &>/dev/null; then
        MSG="$TIMESTAMP - NETWORK UP: $HOST is reachable"
    else
        MSG="$TIMESTAMP - NETWORK DOWN: $HOST is NOT reachable"
    fi
    echo "$MSG" | tee -a "$LOGFILE"
    sleep 30
done
