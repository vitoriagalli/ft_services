#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
  mkdir -p /run/mysqld
fi

cat << EOF > config.sql
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND HOST NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' or Db='test\\_%';
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'admin';
EOF

chmod +w config.sql

mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql

mysqld --user=root --skip_networking=0 --init-file=/config.sql




# ## You can start the MariaDB daemon with:
# ## cd '/usr' ; /usr/bin/mysqld_safe --datadir='/var/lib/mysql'

# ## You can test the MariaDB daemon with mysql-test-run.pl
# ## cd '/usr/mysql-test' ; perl mysql-test-run.pl



# if [ ! -d "/run/mysqld" ]; then
#   mkdir -p /run/mysqld
# fi

# if [ -d /app/mysql ]; then
#   echo "[i] MySQL directory already present, skipping creation"
# else
#   echo "[i] MySQL data directory not found, creating initial DBs"

#   mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql > /dev/null

# #   tfile=`mktemp`
# #   if [ ! -f "$tfile" ]; then
# #       return 1
# #   fi

# #   cat << EOF > $tfile
# # USE mysql;
# # FLUSH PRIVILEGES;
# # GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
# # GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
# # ALTER USER 'root'@'localhost' IDENTIFIED BY '';
# # EOF

#   cat << EOF > config.sql
# DELETE FROM mysql.user WHERE User='';
# DELETE FROM mysql.user WHERE User='root' AND HOST NOT IN ('localhost', '127.0.0.1', '::1');
# DROP DATABASE IF EXISTS test;
# DELETE FROM mysql.db WHERE Db='test' or Db='test\\_%';
# CREATE DATABASE IF NOT EXISTS wordpress;
# GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%' IDENTIFIED BY 'admin';
# GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'admin';
# EOF

# #   if [ "$MYSQL_DATABASE" != "" ]; then
# #     echo "[i] Creating database: $MYSQL_DATABASE"
# #     echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

# #     if [ "$MYSQL_USER" != "" ]; then
# #       echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
# #       echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
# #     fi
# #   fi

# #   /usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tfile
# #   rm -f $tfile
# fi



# # exec /usr/bin/mysqld --user=root --skip_networking=0

# mysqld --user=root --skip_networking=0 --init-file=config.sql


# tail -F /dev/null
