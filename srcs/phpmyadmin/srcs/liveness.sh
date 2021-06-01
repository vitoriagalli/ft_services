#!/bin/sh

pgrep -f telegraf && pgrep -f php-fpm7 && pgrep -f nginx > /dev/null

if [ "$?" != "0" ]; then
    exit 1
fi
