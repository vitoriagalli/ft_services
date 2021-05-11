FROM alpine:3.12

RUN apk update; \
	apk add --no-cache wget nginx \
    php7 \
    php7-fpm \
    php7-opcache \
    php7-gd \
    php7-mysqli \
    php7-zlib \
    php7-curl \
    php7-mbstring \
    php7-json \
	php7-cgi fcgi \
    php7-session \
    php7-iconv \
    php7-xml

COPY ./ /

RUN wget -q https://phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.gz && \
    mkdir -p /var/www/phpmyadmin && \
    tar -xzf phpMyAdmin-latest-english.tar.gz -C /var/www/phpmyadmin --strip-components 1 && \
    mv config.inc.php /var/www/phpmyadmin && \
    rm -f phpMyAdmin-latest-english.tar.gz

RUN mkdir -p /run/nginx

COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./default.conf /etc/nginx/nginx.conf

RUN apk add vim

EXPOSE 5000

CMD ./start.sh