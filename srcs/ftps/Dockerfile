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
    echo admin:admin | chpasswd

EXPOSE 21 30000

CMD ["sh", "start.sh"]



# curl ftps://admin:admin@192.168.49.3:21 -T README.md 
# curl -k --ftp-ssl -u admin:admin ftp://192.168.49.3:21
# curl -k --ftp-ssl -u admin:admin ftp://192.168.49.3:21 -T <FILE> 
# curl -k --ftp-ssl -u admin:admin ftp://192.168.49.3:21/<FILE> -o download.md 



# sudo dpkg --configure -a
# sudo apt install lftp -y
# lftp -e 'set ssl:verify-certificate false' -u admin,admin -p 192.168.49.3:21

