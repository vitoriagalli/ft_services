#!/bin/sh

# /usr/bin/telegraf & --config /etc/telegraf/telegraf.conf &

/usr/sbin/php-fpm7 --nodaemonize &

/usr/sbin/nginx -g 'daemon off;'