#!/bin/bash

# Target host
HOST="192.168.1.10"

# List of usernames to test
USERNAMES=("admin" "user" "guest" "root")

# Loop through usernames and test SSH connection
for username in "${USERNAMES[@]}"; do
    echo "Testing username: $username"
    
    # Attempt to connect via SSH (without password)
    ssh -o BatchMode=yes -o ConnectTimeout=5 $username@$HOST exit

    # Check the result of the SSH connection attempt
    if [ $? -eq 0 ]; then
        echo "Valid username: $username"
    else
        echo "Invalid username: $username"
    fi
done
