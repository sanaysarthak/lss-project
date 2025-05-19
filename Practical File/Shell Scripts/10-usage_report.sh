#!/bin/bash

echo "CPU Load:" $(top -bn1 | awk '/load average/ {print $10 $11 $12}')
echo "Memory Usage:" $(free -h | awk '/Mem:/ {print $3 "/" $2}')
echo "Disk Usage:" && df -h --total | awk '$1=="total" {print $3 "/" $2}'
