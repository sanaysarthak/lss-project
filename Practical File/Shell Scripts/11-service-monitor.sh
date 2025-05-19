#!/bin/bash

services=("apache2" "httpd" "mysqld" "nginx")
echo "Checking Apache, MySQL, and Nginx."

for service in "${services[@]}"; do
    if systemctl list-units --type=service --all | grep -q "$service"; then
        if systemctl is-active --quiet "$service"; then
            echo "[OK] $service is running."
        else
            echo "[ALERT] $service is NOT running!"
        fi
    else
        echo "[INFO] $service is not installed on this system."
    fi
done
