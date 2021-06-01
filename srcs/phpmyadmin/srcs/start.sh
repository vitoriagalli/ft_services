#!/bin/sh

/usr/bin/telegraf --config /etc/telegraf/telegraf.conf & \
/usr/sbin/php-fpm7 & \
/usr/sbin/nginx -g 'daemon off;'
