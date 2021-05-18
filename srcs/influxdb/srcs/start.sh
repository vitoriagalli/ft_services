#!/bin/sh

/usr/bin/telegraf &
/usr/sbin/influxd &
sleep 5

influx -execute "CREATE DATABASE metrics"
influx -execute "USE metrics"
influx -execute "CREATE USER robitett WITH PASSWORD 'Nj7kV6oTpF'"
influx -execute "GRANT ALL ON metrics TO robitett"

# ./livenessprobe.sh


tail -F /dev/null