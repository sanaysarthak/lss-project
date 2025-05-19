#!/bin/bash

count_lines() {
    file="$1"
    if [[ -f "$file" ]]; then
        awk 'END { print NR }' "$file"
    else
        echo "File not found!"
    fi
}

read -p "Enter filename (with extension): " file
count_lines "$file"
