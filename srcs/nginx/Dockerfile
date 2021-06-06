FROM alpine:3.12

RUN apk update; \
    apk add --no-cache nginx openssl vim \
    telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted

COPY srcs/ ./

RUN mkdir -p /etc/telegraf && \
    mv telegraf.conf /etc/telegraf/telegraf.conf

RUN mkdir -p /run/nginx && \
    mv nginx.conf /etc/nginx/conf.d/default.conf && \
    mv index.html /var/www/index.html

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/OU=IT/CN=vscabell" \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt && \
    chmod 600 /etc/ssl/private/nginx-selfsigned.key /etc/ssl/certs/nginx-selfsigned.crt

EXPOSE 80 443

ENTRYPOINT ["sh", "start.sh"]
