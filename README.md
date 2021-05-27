## FT_SERVICES


FTPS

test conection:

curl -k --ftp-ssl -u admin:admin ftp://192.168.49.3:21

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

>>> Se comporta conforme o esperado
kubectl exec deploy/nginx -- pkill nginx
kubectl exec deploy/grafana -- pkill grafana
kubectl exec deploy/ftps -- pkill vsftpd
kubectl exec deploy/influxdb -- pkill influx
kubectl exec deploy/wordpress -- pkill nginx
kubectl exec deploy/phpmyadmin -- pkill nginx

>>>> FTPS esta demorando muito para reiniciar!
kubectl exec deploy/ftps -- pkill vsftpd

>>> MYSQL não esta reiniciando
kubectl exec deploy/mysql -- pkill mysqld 

>>> quando da kill nesses comandos o container não restarta
kubectl exec deploy/phpmyadmin -- pkill php-fpm7
kubectl exec deploy/wordpress -- pkill php-fpm7

>>> o container continua de pé e para de fornecer informação
kubectl exec deploy/QUALQUER CONTAINER -- pkill telegraf



>>> quando da kill no mysql e precisa restartar, perde-se a persistencia 



minikube addons list
habilitar default-storage-class!!
kubectll get hpa




------ ERRO NA PRIMEIRA INICIALIZAÇÃO ------

Start minikube...
[sudo] password for user42: 
😄  minikube v1.20.0 on Ubuntu 18.04 (vbox/amd64)
✨  Using the docker driver based on user configuration

💣  Exiting due to PROVIDER_DOCKER_NOT_RUNNING: deadline exceeded running "docker version --format -": signal: killed
💡  Suggestion: Restart the Docker service
📘  Documentation: https://minikube.sigs.k8s.io/docs/drivers/docker/