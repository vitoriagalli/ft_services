FROM alpine:3.12

RUN apk update; \
	apk add --no-cache nginx openssh openssl vim;

RUN mkdir -p /run/nginx
COPY ./nginx.conf /etc/nginx/nginx.conf
# COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./index.html /var/www/index.html

RUN openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 \
	-subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/OU=IT/CN=vscabell" \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt && \
    chmod 600 /etc/ssl/private/nginx-selfsigned.key /etc/ssl/certs/nginx-selfsigned.crt

EXPOSE 80 443 22

CMD ["nginx", "-g", "daemon off;"]
