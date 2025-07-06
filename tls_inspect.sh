#!/bin/bash

# Usage: ./check_tls.sh example.com
DOMAIN=$1

if [ -z "$DOMAIN" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

# Extract certificate expiration date
EXPIRY_DATE=$(echo | openssl s_client -connect "$DOMAIN:443" 2>/dev/null | \
openssl x509 -noout -enddate | cut -d= -f2)

echo "Certificate for $DOMAIN expires on: $EXPIRY_DATE"
