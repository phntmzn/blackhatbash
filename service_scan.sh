#!/bin/bash

TARGETS=("$@")  # ❶ Assign command-line arguments to TARGETS array

print_help() {
  echo "Usage: ${0} <LIST OF IPs>"
  echo "Example: ${0} 10.1.0.13 10.1.0.14"
}

# ❷ Check if the user provided any target IPs
if [[ ${#TARGETS[@]} -eq 0 ]]; then
  echo "Must provide one or more IP addresses!"
  print_help  # ❸ Print usage instructions
  exit 1
fi

# ❹ Iterate over each target IP
for target in "${TARGETS[@]}"; do
  echo "Scanning ${target}..."

  # ❻ Iterate over the list of TCP ports from /etc/services
  while read -r port; do
    # Use nc (netcat) to check if the port is open (timeout = 1 second)
    if timeout 1 nc -i 1 "${target}" -v "${port}" 2>&1 | grep -q "Connected to"; then  # ❺
      echo "IP: ${target}"
      echo "Port: ${port}"
      echo "Service: $(grep -w "${port}/tcp" /etc/services | awk '{print $1}')"
      echo "----------------------"
    fi
  done < <(grep "/tcp" /etc/services | awk '{print $2}' | tr -d '/tcp')
done
