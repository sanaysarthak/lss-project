#!/bin/bash

HOST="8.8.8.8"  # Google's public DNS server
ping -c 4 $HOST > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "Network is reachable. Successfully pinged $HOST."
else
  echo "Network is unreachable. Failed to ping $HOST."
fi
