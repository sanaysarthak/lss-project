#!/bin/bash

echo "Employee" > employee.txt
ln -s employee.txt soft_link.txt
# ln employee.txt hard_link.txt
ls -li employee.txt soft_link.txt
rm soft_link.txt
# ls -li employee.txt hard_link.txt
