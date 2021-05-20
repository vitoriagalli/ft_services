#!/bin/sh

/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf &
/usr/sbin/pure-ftpd -p 30000:30000 -P 192.168.49.2 &
tail -F /dev/null