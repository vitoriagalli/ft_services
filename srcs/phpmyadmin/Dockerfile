FROM alpine:3.12

RUN apk update; \
	apk add --no-cache wget nginx vim \
    php7 php7-fpm php7-openssl php7-session php7-mbstring \
    php7-mysqli php7-opcache php7-curl php7-json \
    php7-gd php7-zlib php7-iconv php7-xml 

COPY ./ /

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-english.tar.gz && \
    tar -xzf phpMyAdmin-5.1.0-english.tar.gz && \
    mkdir -p /var/www/phpmyadmin && \
    mv phpMyAdmin-5.1.0-english/* /var/www/phpmyadmin/ && \
    mv config.inc.php /var/www/phpmyadmin/config.inc.php && \
    rm -rf phpMyAdmin-5.1.0-english.tar.gz phpMyAdmin-5.1.0-english
    
RUN mkdir -p /run/nginx

COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./default.conf /etc/nginx/nginx.conf

EXPOSE 5000

CMD ./start.sh