#! /bin/bash

delete_environment()
{
    # minikube stop
    # minikube delete
    # rm -rf ~/.kube/config
    # eval $(minikube docker-env)
    # docker stop $(docker images -a -q)
    # docker rm $(docker images -a -q)
    # docker rmi $(docker images -a -q)
    minikube stop
    minikube delete
    rm -rf ~/.kube/config
    # eval $(minikube docker-env)  
    # docker rm -f $(docker ps -aq --filter name=k8s)
    # docker rmi -f $(docker images -aq --filter name=vscabell)
}

clean_environment()
{
    kubectl delete deployments --all 
    kubectl delete services --all 
    kubectl delete pods --all 
    # kubectl delete pvc --all 
    # kubectl delete pv --all
    # kubectl delete sc --all 
    # kubectl delete cm --all
    
    # eval $(minikube docker-env)  
    docker stop -f $(docker ps -aq --filter name=k8s)
    docker rm -f $(docker ps -aq --filter name=k8s)
    docker rmi -f $(docker images -aq --filter name=vscabell)
}

start_minikube()
{
    # eval $(minikube docker-env)
    sudo chmod 666 /var/run/docker.sock 
    minikube start --driver=docker
}

enable_addons()
{
    minikube addons enable storage-provisioner
    minikube addons enable metrics-server
    minikube addons enable dashboard
}

install_metallb()
{
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
    # # on first install only
    kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
    minikube addons enable metallb
}

atribute_ip()
{
    MINIKUBEIP=$(minikube ip)
    
    IP=${MINIKUBEIP::-1}"$((${MINIKUBEIP: -1} + 1))"

    # tmp=$IP
    # while [ ${tmp: -1} != '.' ]
    # do
    #     tmp=${tmp::-1}
    # done

    # LASTIP=$tmp"249"

    sed -i "s/FIRSTIP-LASTIP/$IP-$IP/g" ./srcs/k8s/metallb.yaml

    sed -i "s/IP/$IP/g" ./srcs/ftps/srcs/vsftpd.conf

    sed -i "s/CLUSTER_IP/$IP/g" ./srcs/mysql/srcs/wordpress.sql

}

build_images()
{
    eval $(minikube docker-env)
    docker build srcs/nginx -t nginx:vscabell
    docker build srcs/ftps -t ftps:vscabell
    docker build srcs/mysql -t mysql:vscabell
    docker build srcs/phpmyadmin -t phpmyadmin:vscabell
    docker build srcs/wordpress -t wordpress:vscabell
    docker build srcs/grafana -t grafana:vscabell
    docker build srcs/influxdb -t influxdb:vscabell
}

apply_config_files()
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

eval $(minikube docker-env)

if [ "$1" == "apply" ]; then
    clean_environment
    build_images
    apply_config_files
elif [ "$1" == "del" ]; then
    delete_environment
else
    delete_environment
    start_minikube
    install_metallb
    enable_addons
    atribute_ip
    build_images
    apply_config_files
fi

minikube dashboard &> /dev/null &