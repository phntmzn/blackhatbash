#!/bin/bash

# Define variables
GATEWAY="192.168.1.1"
DESTINATION="10.10.10.0/24"

# Add a route
echo "Adding route to $DESTINATION via $GATEWAY..."
sudo route -n add "$DESTINATION" "$GATEWAY"

# Verify the new route
echo "Current routing table:"
netstat -rn

# Delete the route (uncomment to use)
# echo "Deleting route to $DESTINATION..."
# sudo route -n delete "$DESTINATION"
