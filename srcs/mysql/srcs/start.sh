#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
  mkdir -p /run/mysqld
fi

/usr/bin/mysqld_safe --datadir='/var/lib/mysql'

cat << EOF > config.sql
CREATE DATABASE IF NOT EXISTS wordpress;
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'admin';
FLUSH PRIVILEGES;
EOF

chmod +w config.sql
mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql
mysqld --user=root --skip_networking=0 --init-file=/config.sql & \
sleep 10 && mysql wordpress < wordpress.sql;
/usr/bin/telegraf --config /etc/telegraf/telegraf.conf