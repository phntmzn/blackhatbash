#!/bin/bash

# Valid seed input
SEED="admin123"

# Target URL for fuzzing
TARGET_URL="http://example.com/login"

# Function to randomly mutate the input
mutate_input() {
    local input="$1"
    local len=${#input}
    local pos=$((RANDOM % len))
    local char=$(echo "$input" | cut -c $((pos + 1)))
    local new_char=$(echo "$char" | tr 'a-zA-Z0-9' '0-9a-zA-Z')

    # Replace a random character in the input
    echo "${input:0:pos}$new_char${input:pos + 1}"
}

# Fuzzing loop
for i in {1..50}; do
    FUZZED_INPUT=$(mutate_input "$SEED")
    echo "Testing with mutated input: $FUZZED_INPUT"

    # Send the mutated input to the web form
    RESPONSE=$(curl -s -X POST -d "username=$FUZZED_INPUT&password=test" $TARGET_URL)

    # Check for anomalies in the response
    if [[ $RESPONSE == *"500 Internal Server Error"* ]]; then
        echo "Potential vulnerability found with input: $FUZZED_INPUT"
        break
    fi
done
