#!/bin/sh

pgrep -f telegraf && pgrep -f grafana-server > /dev/null

if [ "$?" != "0" ]; then
    exit 1
fi
