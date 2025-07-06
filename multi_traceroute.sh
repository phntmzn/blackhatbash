#!/bin/bash

# List of destinations to trace
DESTINATIONS=("google.com" "cloudflare.com" "apple.com")

# Loop through each destination and run traceroute
for destination in "${DESTINATIONS[@]}"; do
    echo "Tracing route to $destination..."
    traceroute -m 30 -w 3 "$destination"
    echo "--------------------------------------"
done
