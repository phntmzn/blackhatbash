#!/bin/bash

# Define variables (replace en0 with your interface and 192.168.1.1 with your gateway)
INTERFACE="en0"
GATEWAY="192.168.1.1"

# Enable IP forwarding
echo "Enabling IP forwarding..."
sudo sysctl -w net.inet.ip.forwarding=1

# Create a temporary PF configuration file
echo "Configuring packet forwarding rules..."
cat <<EOF | sudo tee /etc/pf.traffic.conf
rdr on $INTERFACE inet proto tcp from any to any -> $GATEWAY
pass out route-to ($INTERFACE $GATEWAY) from any to any
EOF

# Load and enable the PF rules
echo "Loading PF rules..."
sudo pfctl -f /etc/pf.traffic.conf

# Enable the packet filter
echo "Enabling PF..."
sudo pfctl -e

echo "Traffic forwarding to $GATEWAY via $INTERFACE is set up."
