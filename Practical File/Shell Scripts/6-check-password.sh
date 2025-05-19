#!/bin/bash

output="users.txt"
read -p "Enter username: " username

if [[ "$username" =~ ^[^a-zA-Z0-9] ]]; then
    echo "Invalid! Username cannot start with a special character"
    exit 1
elif grep -q "^$username$" "$output"; then
    echo "User with username already exists!"
    exit 1
fi

echo "$username" >> "$output"
echo "Username successfully stored in the file"
read -p "Enter password: " password
echo

if [[ ${#password} -lt 8 ]]; then
    echo "Weak Password: It must be at least 8 characters long."
    exit 1
fi

if ! [[ "$password" =~ [0-9] && "$password" =~ [A-Z] && "$password" =~ [[:punct:]] ]]; then
    echo "Weak Password: It must contain at least 1 digit, 1 uppercase letter, and 1 special character."
    exit 1
fi

echo "Strong Password!"
