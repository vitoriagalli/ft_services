#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
  mkdir -p /run/mysqld
fi

/usr/bin/mysqld_safe --datadir='/var/lib/mysql'

mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql
mysqld --user=root --skip_networking=0 &

mysql << EOF
CREATE DATABASE IF NOT EXISTS wordpress;
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'admin';
FLUSH PRIVILEGES;
EOF

if [ ! -f /var/lib/mysql/wordpress ]; then
	mysql wordpress < wordpress.sql
fi

/usr/bin/telegraf --config /etc/telegraf/telegraf.conf