#!/bin/bash

echo "Login attempts:"
echo ""
last
lastb
# grep "login" /var/log/boot.log
# grep "login" /var/log/auth.log

echo -e "\nPassword-related logs:"
journalctl | grep -i "password"
journalctl | grep -i "authentication"
# grep "pass" /etc/passwd

echo -e "\nTotal users:"
cat /etc/passwd | wc -l
