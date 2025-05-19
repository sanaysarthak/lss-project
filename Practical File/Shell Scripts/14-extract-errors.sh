#!/bin/bash
# Script to Extract ERROR messages using journalctl

OUTPUT="/tmp/error_log_report.txt"
journalctl -p err -b > "$OUTPUT"
echo "Error messages saved from journalctl to: $OUTPUT"
