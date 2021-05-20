#!/bin/sh

/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf &
tail -F /dev/null