#!/bin/sh

/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &
tail -F /dev/null