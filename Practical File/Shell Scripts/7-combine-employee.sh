#!/bin/bash

paste -d ' ' employee.txt salary.txt > combined_employee_data.txt
# join employee.txt salary.txt > combined_employee_data.txt
cat combined_employee_data.txt
echo "Combined employee and salary data stored in $output_file"
