#!/bin/bash

# Target URL
URL="http://example.com/login"

# Character set for generating random input
CHARS="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()"

# Function to generate random input
generate_fuzz() {
    local LENGTH=$1
    INPUT=""
    for ((i = 0; i < LENGTH; i++)); do
        INPUT+="${CHARS:RANDOM%${#CHARS}:1}"
    done
    echo "$INPUT"
}

# Loop to send multiple fuzz inputs
for i in {1..50}; do
    FUZZ_USERNAME=$(generate_fuzz $((RANDOM % 10 + 5)))  # Random username
    FUZZ_PASSWORD=$(generate_fuzz $((RANDOM % 10 + 5)))  # Random password

    echo "Testing with username: $FUZZ_USERNAME and password: $FUZZ_PASSWORD"

    # Send POST request with fuzzed inputs
    RESPONSE=$(curl -s -X POST -d "username=$FUZZ_USERNAME&password=$FUZZ_PASSWORD" $URL)

    # Check if the response contains any error or crash indications
    if [[ $RESPONSE == *"500 Internal Server Error"* ]]; then
        echo "Potential vulnerability found with input: $FUZZ_USERNAME / $FUZZ_PASSWORD"
        break
    fi
done
