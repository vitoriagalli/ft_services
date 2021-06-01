#!/bin/sh

pgrep -f telegraf && pgrep -f nginx > /dev/null

if [ "$?" != "0" ]; then
    exit 1
fi
