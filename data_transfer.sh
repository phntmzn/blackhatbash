#!/bin/bash

# Variables
URL="https://example.com"
PORT=443

echo "Fetching content from $URL..."

# Step 1: Use openssl to connect (Transport + Encoding layer: TLS)
echo | openssl s_client -connect example.com:$PORT > /dev/null

# Step 2: Fetch content with curl (Application Layer: Content)
RESPONSE=$(curl -s $URL)

echo "Received content:"
echo "$RESPONSE"

# Step 3: Encode the content using base64 (Encoding Layer)
ENCODED_CONTENT=$(echo "$RESPONSE" | base64)
echo "Encoded content (base64):"
echo "$ENCODED_CONTENT"
