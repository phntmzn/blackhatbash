#!/bin/bash

# Function to canonicalize a file path
canonicalize_path() {
    local INPUT_PATH="$1"
    local CANONICAL_PATH=$(realpath -m "$INPUT_PATH" 2>/dev/null)

    if [[ -z "$CANONICAL_PATH" || ! -e "$CANONICAL_PATH" ]]; then
        echo "Invalid path: $INPUT_PATH"
        exit 1
    fi

    echo "Canonicalized Path: $CANONICAL_PATH"
}

# Test the function with a user-provided path
read -p "Enter a file path: " USER_INPUT
canonicalize_path "$USER_INPUT"
