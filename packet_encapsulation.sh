#!/bin/bash

# Variables
APPLICATION_DATA="GET / HTTP/1.1"
SOURCE_PORT=12345
DEST_PORT=80
SOURCE_IP="192.168.1.10"
DEST_IP="142.250.64.78"
SRC_MAC="00:1A:2B:3C:4D:5E"
DST_MAC="5E:4D:3C:2B:1A:00"

# Simulating Encapsulation
echo "Application Layer Data: $APPLICATION_DATA"
echo "Transport Layer Header: Source Port $SOURCE_PORT, Destination Port $DEST_PORT"
echo "Network Layer Header: Source IP $SOURCE_IP, Destination IP $DEST_IP"
echo "Data Link Layer Header: Source MAC $SRC_MAC, Destination MAC $DST_MAC"
echo "Physical Layer: Data transmitted as bits over the wire"
