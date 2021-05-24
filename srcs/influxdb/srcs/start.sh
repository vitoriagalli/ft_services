#!/bin/sh

/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &
/usr/sbin/influxd &
tail -F /dev/null