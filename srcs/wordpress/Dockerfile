FROM alpine:3.12

RUN apk update; \
    apk add --no-cache wget nginx openssl vim \
    php7 php7-fpm php7-openssl php7-session php7-mbstring \
    php7-mysqli php7-opcache php7-curl php7-json \
    php7-gd php7-zlib php7-iconv php7-xml \
    telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted

COPY srcs/ ./

RUN wget http://wordpress.org/wordpress-5.4.2.tar.gz && \
    tar -xzf wordpress-5.4.2.tar.gz && \
    mv wordpress /var/www/ && \
    mv wp-config.php /var/www/wordpress/ && \
    rm -rf wordpress-5.4.2.tar.gz

RUN mkdir -p /etc/telegraf; \
    mv telegraf.conf /etc/telegraf/telegraf.conf

RUN mkdir -p /run/nginx; \
    # mv wp-nginx.conf /etc/nginx/nginx.conf
    mv wp-nginx.conf /etc/nginx/conf.d/default.conf

# RUN openssl req -x509 -nodes -days 365 \
#     -newkey rsa:2048 \
#     -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/OU=IT/CN=vscabell" \
#     -keyout /etc/ssl/private/nginx-selfsigned.key \
#     -out /etc/ssl/certs/nginx-selfsigned.crt && \
#     chmod 600 /etc/ssl/private/nginx-selfsigned.key /etc/ssl/certs/nginx-selfsigned.crt

EXPOSE 5050

CMD ["sh", "start.sh"]
