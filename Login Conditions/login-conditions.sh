#!/bin/bash

# define the output file path
savelist="all_usernames.txt"

echo -e "Username and Password Analyzer!\n"

username_analysis() {
    echo ""
    read -p "Enter username: " username

    # -q means quiet (it does not print matching lines to the terminal)

    if grep -q "$username" "$savelist"; then
        echo "Username '$username' already exists! Choose a unique one."
    # check if username starts with digits or underscore
    elif [[ "$username" =~ ^[0-9_] ]]; then
        echo "Invalid username! It cannot start with a number or an underscore."
    # + means any of the previous characters (a-z, A-Z, 0-9, _)
    elif [[ ! "$username" =~ ^[a-zA-Z0-9_]+$ ]]; then
        echo "Invalid username! Special characters are not allowed."
    else
        echo "$username" >> "$savelist"
        echo "Username '$username' added succesfully!"
    fi
}

password_analysis() {
    read -p "Enter password: " password

    # checks length
    if [[ ${#password} -lt 8 ]]; then
        echo "Password must be at least 8 characters long."
    # checks numeric character
    elif [[ ! "$password" =~ [0-9] ]]; then
        echo "Password must contain at least one digit (0-9)."
    # checks uppercase character
    elif [[ ! "$password" =~ [A-Z] ]]; then
        echo "Password must contain at least one uppercase letter (A-Z)."
    # checks special character (^ is used to not check anything else)
    elif [[ ! "$password" =~ [^a-zA-Z0-9] ]]; then
        echo "Password must contain at least one special character."
    else
        echo "It is a strong password!"
    fi
}

menu() {
    echo "Enter 1. for Username Analysis."
    echo "Enter 2. for Password Analysis."
    read -p "Enter your choice: " choice

    case $choice in
        1) username_analysis ;;
        2) password_analysis ;;
        *) echo "Invalid choice! Please try again."
    esac
}

# Running the main function
menu