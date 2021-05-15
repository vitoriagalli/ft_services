#!/bin/sh

grafana-server &
telegraf --config /etc/telegraf/telegraf.conf &
tail -f /dev/null /dev/null
