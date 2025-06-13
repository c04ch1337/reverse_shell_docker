FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    netcat-traditional \
    ncat \
    curl \
    wget \
    openssh-server \
    socat \
    python3 \
    iputils-ping \
    nginx \
    openssl \
    && apt-get clean

RUN useradd -m ssh_admin && echo "ssh_admin:ssh_admin" | chpasswd

# Setup SSH
RUN mkdir /var/run/sshd
RUN echo 'PermitRootLogin no' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Self-signed TLS cert
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/key.pem -out /etc/nginx/cert.pem \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=localhost"

# NGINX config
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Web + Logs
RUN mkdir -p /app/logs /usr/share/nginx/html
COPY reverse_shell.sh /app/reverse_shell.sh
COPY www/ /usr/share/nginx/html/
RUN chmod +x /app/reverse_shell.sh

WORKDIR /app

CMD service ssh start && \
    echo "[*] SSH: ssh_admin@localhost:2222 / Password: ssh_admin" && \
    echo "[*] HTTPS Webserver: https://localhost/ on port 443 (NGINX)" && \
    nginx && /app/reverse_shell.sh

EXPOSE 2222
EXPOSE 443
EXPOSE 4444
EXPOSE 5555
EXPOSE 8080
