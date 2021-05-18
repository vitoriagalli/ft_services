FROM alpine:3.12

RUN apk update; \
    apk add --no-cache wget nginx openssl vim \
    php7 php7-fpm php7-openssl php7-session php7-mbstring \
    php7-mysqli php7-opcache php7-curl php7-json \
    php7-gd php7-zlib php7-iconv php7-xml 

COPY srcs/ ./

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-english.tar.gz && \
    tar -xzf phpMyAdmin-5.1.0-english.tar.gz && \
    mkdir -p /var/www/phpmyadmin && \
    mv phpMyAdmin-5.1.0-english/* /var/www/phpmyadmin/ && \
    mv config.inc.php /var/www/phpmyadmin/config.inc.php && \
    rm -rf phpMyAdmin-5.1.0-english.tar.gz phpMyAdmin-5.1.0-english

RUN apk add --no-cache telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted && \
    mkdir -p /etc/telegraf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/OU=IT/CN=vscabell" \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt && \
    chmod 600 /etc/ssl/private/nginx-selfsigned.key /etc/ssl/certs/nginx-selfsigned.crt

RUN mkdir -p /run/nginx; \
    mv pma-nginx.conf /etc/nginx/nginx.conf 
    # cp pma-nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 5000

CMD ["sh", "start.sh"]