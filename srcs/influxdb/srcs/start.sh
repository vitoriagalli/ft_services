#!/bin/sh

/usr/bin/telegraf &
/usr/sbin/influxd &
sleep 5

influx -execute "CREATE DATABASE telegraf"
influx -execute "USE telegraf"
influx -execute "CREATE USER admin WITH PASSWORD 'admin'"
influx -execute "GRANT ALL ON metrics TO admin"

tail -F /dev/null