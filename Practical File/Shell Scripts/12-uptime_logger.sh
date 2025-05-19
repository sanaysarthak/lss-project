#!/bin/bash

uptime | tee -a /var/log/sys_stats.log
