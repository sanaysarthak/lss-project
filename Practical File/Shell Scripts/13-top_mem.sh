#!/bin/bash

echo "Top 5 memory-consuming processes:"
echo
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
