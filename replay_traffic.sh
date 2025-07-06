#!/bin/bash

# Variables
INTERFACE="en0"
PCAP_FILE="traffic_capture.pcap"
MODIFIED_PCAP="modified_capture.pcap"
TARGET_MAC="00:11:22:33:44:55"

# Capture traffic
echo "Capturing traffic on $INTERFACE..."
sudo tcpdump -i $INTERFACE -c 50 -w $PCAP_FILE

# Modify the MAC address in the captured packets
echo "Modifying MAC address in captured packets..."
sudo tcprewrite --enet-dmac=$TARGET_MAC --infile=$PCAP_FILE --outfile=$MODIFIED_PCAP

# Replay the modified traffic
echo "Replaying modified traffic..."
sudo tcpreplay --intf1=$INTERFACE $MODIFIED_PCAP

echo "Done!"
