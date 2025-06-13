# 🐚 Docker Reverse Shell Toolkit

![Docker Logo](https://www.docker.com/wp-content/uploads/2022/03/horizontal-logo-monochromatic-white.png)

This project provides a **simple and modular Bash-based Reverse Shell Docker container** for penetration testing and red team simulations. It allows you to spawn reverse shells with ease and minimal setup. Output and logs are mounted to host for easy access.

---

## ✨ Features

- 🧾 Auto-generated `.bat` droppers with runtime IP/Port injection
- 🌐 Web UI for live payload generation (`payload_generator.html`)
- ⚙️ CLI-based dynamic reverse shell generator with output log
- 🔐 HTTPS server using NGINX with self-signed TLS
- 🧪 Payloads for:
  - PowerShell (encoded)
  - SigmaPotato
  - PrintSpoofer
  - ncat / socat / msfvenom
- 📦 Docker Volumes for logs and payloads
- 🔐 SSH access (user: `ssh_admin`, pass: `ssh_admin`, port: `2222`)

---

## 🚀 Quick Start

```bash
docker build -t reverse-shell .
docker run -it --rm \
  -v $(pwd)/logs:/app/logs \
  -v $(pwd)/www:/usr/share/nginx/html \
  -p 443:443 -p 4444:4444 -p 5555:5555 -p 2222:2222 \
  reverse-shell
```

---

## 🧾 Web Payload Generator

Visit:
```
https://<your_ip>/payload_generator.html
```

Enter your IP and Port to dynamically generate:
- Base64 PowerShell
- SigmaPotato
- PrintSpoofer

---

## 📁 CLI Payload Generator

After container starts, you'll be prompted to enter IP and Port. This will:
- Create encoded payloads
- Save them to `/usr/share/nginx/html/reverse_payloads.txt`
- Print to screen

---

## 🔐 Access

| Service       | Details                        |
|---------------|--------------------------------|
| HTTPS         | https://<your_ip> (port 443)   |
| SSH           | ssh_admin / ssh_admin (port 2222) |
| Web Generator | `/payload_generator.html`      |

---

## 🛠️ Notes

- Adjust IP/Port live at runtime via prompts
- All files hosted from `/usr/share/nginx/html`
- Logs and payloads saved under `logs/` and `www/` via volume mounts

---

> ⚠️ This is for **authorized testing only**. Unauthorized use is illegal and unethical.
