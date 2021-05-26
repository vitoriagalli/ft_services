## FT_SERVICES


FTPS

upload:

<!-- curl ftps://admin:admin@192.168.49.3:21 -T README.md  -->
curl -k --ftp-ssl -u admin:admin ftp://192.168.49.3:21 -T [FILE]

download:

curl -k --ftp-ssl -u admin:admin ftp://192.168.49.3:21/[FILE] -o [NEW_FILE_NAME]

WORDPRESS

logar

https://IP:5050/wp-login.php

users:
contributor: user1 user1
contributor: user2 user2
contributor: user3 user3



COMMANDS TO KILL PROCESSES

kubectl exec deploy/ftps -- pkill vsftpd
kubectl exec deploy/grafana -- pkill grafana
kubectl exec deploy/telegraf -- pkill telegraf
kubectl exec deploy/influxdb -- pkill influx
kubectl exec deploy/wordpress -- pkill nginx
kubectl exec deploy/wordpress -- pkill php-fpm7
kubectl exec deploy/phpmyadmin -- pkill nginx
kubectl exec deploy/phpmyadmin -- pkill php-fpm7
kubectl exec deploy/mariadb -- pkill /usr/bin/mysqld 
kubectl exec deploy/nginx -- pkill nginx


