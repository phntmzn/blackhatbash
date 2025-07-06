#!/bin/bash

# Variables
INTERFACE="en0"
PACKET_COUNT=5
PCAP_FILE="packets.pcap"

# Capture packets
echo "Capturing $PACKET_COUNT packets on interface $INTERFACE..."
sudo tcpdump -i $INTERFACE -c $PACKET_COUNT -w $PCAP_FILE

# Display the packets in hex format
echo "Generating hex dump..."
tcpdump -r $PCAP_FILE -XX
