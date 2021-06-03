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
$ ./setup.sh
```

#### System flowchart

![flow](https://user-images.githubusercontent.com/56961723/120088927-fbc7c700-c0cb-11eb-8da9-b44a80f7f85e.png)




<details>
  <summary>More info</summary>
  
  ##### Terminal
  ![terminal](https://user-images.githubusercontent.com/56961723/120122211-d98e8180-c17d-11eb-81cf-236ef3e1cb37.jpg)
  
  ##### Kubernetes Dashboard
  ![kubernetes_dash](https://user-images.githubusercontent.com/56961723/120122213-db584500-c17d-11eb-8325-5ec126bace6e.jpg)
  
  ##### Nginx Index
  ![index](https://user-images.githubusercontent.com/56961723/120122206-d4313700-c17d-11eb-9e39-dac739a839a4.jpg)
  
  ##### Wordpress
  ![word](https://user-images.githubusercontent.com/56961723/120122218-ddba9f00-c17d-11eb-9c1b-6bc18a42f5e1.jpg)
  
  ##### PhpMyAdmin
  ![php](https://user-images.githubusercontent.com/56961723/120122216-dc897200-c17d-11eb-89d0-fbc6c3bc2715.jpg)
  
  ##### Grafana Dashboard
  ![dash](https://user-images.githubusercontent.com/56961723/120122208-d7c4be00-c17d-11eb-8296-d8b8e06608eb.jpg)
