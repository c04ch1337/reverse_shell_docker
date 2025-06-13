FROM ubuntu:latest

RUN apt-get update && apt-get install -y     netcat     curl     wget     socat     openssl     iputils-ping     && apt-get clean

WORKDIR /app

COPY reverse_shell.sh /app/reverse_shell.sh
RUN chmod +x /app/reverse_shell.sh

ENTRYPOINT ["/app/reverse_shell.sh"]
