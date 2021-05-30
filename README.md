# FT_SERVICES
![](https://img.shields.io/badge/Kubernetes-darkblue)
![](https://img.shields.io/badge/Docker-blue)


### Introduction

This project consists of implementing an infrastructure with different services. For this, we will use Kubernetes.
Kubernetes is an open-source container-orchestration system for automating computer application deployment, scaling, and management.
Each service works in a dedicated container and, for performance reasons, each container image is build from scratch from the alpine linux base image.
The access to the cluster is made through a load balancer.


### Services and Components

`MetalLB`: a Load Balancer that manages external access to its services. It is the only entrance to the cluster.

`Nginx`: an HTTP and reverse proxy server

`Wordpress`: a content management system (CMS) written in PHP that uses a MySQL database.

`Mysql`: relational database management system used by Wordpress to store its data.

`phpMyAdmin`: an administration tool for MySQL.

`FTPS`: a protocol, secured by SSL, used for the transfer of computer files from a server to a client on a computer network.

`Grafana`: a analytics and interactive visualization web application. Allows you to query, view, alert, and explore your metrics from Time Series Database Storage(TSDB).

`InfluxDB`: a time series database optimized for fast, high-availability storage and retrieval of time series data.

`Telegraf`: a plugin-driven server agent for collecting and sending metrics and events from databases and systems.


### Usage

A bash script is used to launch the cluster.

```bash
$ git clone https://github.com/vscabell/ft_services
$ cd ft_services
$ ./setup
```



![flow](https://user-images.githubusercontent.com/56961723/120088927-fbc7c700-c0cb-11eb-8da9-b44a80f7f85e.png)


COMMANDS TO KILL PROCESSES

- Se comporta conforme o esperado
kubectl exec deploy/nginx -- pkill nginx
kubectl exec deploy/grafana -- pkill grafana
kubectl exec deploy/ftps -- pkill vsftpd
kubectl exec deploy/influxdb -- pkill influx
kubectl exec deploy/wordpress -- pkill nginx
kubectl exec deploy/phpmyadmin -- pkill nginx

- FTPS esta demorando muito para reiniciar!
kubectl exec deploy/ftps -- pkill vsftpd

- MYSQL não esta reiniciando
kubectl exec deploy/mysql -- pkill mysqld 

- quando da kill nesses comandos o container não restarta
kubectl exec deploy/phpmyadmin -- pkill php-fpm7
kubectl exec deploy/wordpress -- pkill php-fpm7

- o container continua de pé e para de fornecer informação
kubectl exec deploy/QUALQUER CONTAINER -- pkill telegraf

- quando da kill no mysql e precisa restartar, perde-se a persistencia
quando da kill no php-fpm7, perde-se a persistencia! pq??????



README for all componets
https://github.com/charMstr/ft_services
