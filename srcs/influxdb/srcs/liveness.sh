#!/bin/sh

pgrep -f telegraf && pgrep -f influxd > /dev/null

if [ "$?" != "0" ]; then
    exit 1
fi