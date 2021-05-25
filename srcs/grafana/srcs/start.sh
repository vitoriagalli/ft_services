#!/bin/sh

/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &
grafana-server --homepath=/grafana-7.5.6
