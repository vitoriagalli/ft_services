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
    php7-session;

COPY ./ ./

RUN wget -q http://wordpress.org/wordpress-5.4.2.tar.gz && \
    mkdir -p /var/www/localhost/wordpress && \
    tar -xzf wordpress-5.4.2.tar.gz -C /var/www/localhost/ && \
	rm -rf wordpress-5.4.2.tar.gz && \
    mv wp-config.php /var/www/localhost/wordpress/


EXPOSE 5050 80

CMD ./start.sh