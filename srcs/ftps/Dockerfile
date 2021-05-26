FROM alpine:3.12

RUN apk update; \
    apk add --no-cache vsftpd openssl vim \
    telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted

COPY srcs/ ./

RUN mkdir -p /etc/telegraf && \
    mv telegraf.conf /etc/telegraf/telegraf.conf;

RUN mkdir -p /etc/vsftpd/ && \
    mv vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/OU=IT/CN=vscabell" \
    -keyout /etc/ssl/private/ftps-selfsigned.key \
    -out /etc/ssl/certs/ftps-selfsigned.crt && \
    chmod 600 /etc/ssl/private/ftps-selfsigned.key /etc/ssl/certs/ftps-selfsigned.crt

RUN adduser -D admin && \
    echo admin:admin | chpasswd && \
    chown ftp:ftp -R /srv/

EXPOSE 21 30000

CMD ["sh", "start.sh"]