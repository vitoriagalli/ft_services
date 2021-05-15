#!/bin/sh

influxd &
telegraf --config /etc/telegraf/telegraf.conf &
tail -f /dev/null /dev/null
