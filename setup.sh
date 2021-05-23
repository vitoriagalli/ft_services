#! /bin/bash

start_environment()
{
    sudo chmod 666 /var/run/docker.sock 
    minikube --cpus=2 --memory 3000 start --driver=docker
    minikube addons enable storage-provisioner
    minikube addons enable metrics-server
    minikube addons enable dashboard
    minikube addons enable ingress
}

delete_environment()
{
    if [[ $(minikube status | grep -c "Running") != 0 ]]; then
        minikube stop
        minikube delete
    fi
    rm -rf ~/.kube/config
}

apply_config()
{
    kubectl apply -f srcs/k8s/metallb.yaml
    kubectl apply -f srcs/k8s/nginx.yaml
    kubectl apply -f srcs/k8s/ftps.yaml
    kubectl apply -f srcs/k8s/mysql.yaml
    kubectl apply -f srcs/k8s/phpmyadmin.yaml
    kubectl apply -f srcs/k8s/wordpress.yaml
    kubectl apply -f srcs/k8s/grafana.yaml
    kubectl apply -f srcs/k8s/influxdb.yaml 
}

clean_config()
{
    kubectl delete -f srcs/k8s/metallb.yaml
    kubectl delete -f srcs/k8s/nginx.yaml
    kubectl delete -f srcs/k8s/ftps.yaml
    kubectl delete -f srcs/k8s/mysql.yaml
    kubectl delete -f srcs/k8s/phpmyadmin.yaml
    kubectl delete -f srcs/k8s/wordpress.yaml
    kubectl delete -f srcs/k8s/grafana.yaml
    kubectl delete -f srcs/k8s/influxdb.yaml 
}

build_images()
{
    docker build srcs/nginx -t nginx:vscabell
    docker build srcs/ftps -t ftps:vscabell
    docker build srcs/mysql -t mysql:vscabell
    docker build srcs/phpmyadmin -t phpmyadmin:vscabell
    docker build srcs/wordpress -t wordpress:vscabell
    docker build srcs/grafana -t grafana:vscabell
    docker build srcs/influxdb -t influxdb:vscabell  
}

clean_images()
{
    docker stop $(docker ps -aq --filter name=k8s)
    docker rm $(docker ps -aq --filter name=k8s)
    docker rmi -f nginx:vscabell
    docker rmi -f ftps:vscabell
    docker rmi -f mysql:vscabell
    docker rmi -f phpmyadmin:vscabell
    docker rmi -f wordpress:vscabell
    docker rmi -f grafana:vscabell
    docker rmi -f influxdb:vscabell  
}

install_metallb()
{
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
    kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
    minikube addons enable metallb
}

atribute_ip()
{
    MINIKUBEIP=$(minikube ip)
    IP=${MINIKUBEIP::-1}"$((${MINIKUBEIP: -1} + 1))"
    sed -i "s/FIRSTIP-LASTIP/$IP-$IP/g" ./srcs/k8s/metallb.yaml
    sed -i "s/IP/$IP/g" ./srcs/ftps/srcs/vsftpd.conf
    sed -i "s/CLUSTER_IP/$IP/g" ./srcs/mysql/srcs/wordpress.sql
}

if [ "$1" == "apply" ]; then
    clean_config
    eval $(minikube docker-env)
    clean_images
    atribute_ip
    build_images
    apply_config
elif [ "$1" == "del" ]; then
    delete_environment
else
    delete_environment
    start_environment
    eval $(minikube docker-env)
    install_metallb
    atribute_ip
    build_images
    apply_config
fi

minikube dashboard &> /dev/null &
