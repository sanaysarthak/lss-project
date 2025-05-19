#!/usr/bin/bash

read -p "Enter filename (with extension): " file
if [[ ! -r "$file" ]]; then
  echo "Error: '$file' not found or not readable." >&2
  exit 1
fi

awk '/fail|error/' "$file"
