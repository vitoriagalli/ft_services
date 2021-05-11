#!/bin/sh

# /usr/bin/telegraf &

/usr/sbin/php-fpm7 &

/usr/sbin/nginx -g "daemon off;"

# ./livenessprobe.sh