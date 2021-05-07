#! /bin/bash

delete_environment()
{
    kubectl delete deployments --all 
    kubectl delete services --all 
    kubectl delete pods --all 
    kubectl delete pvc --all 
    kubectl delete pv --all 
    minikube stop
    minikube delete
}

clean_environment()
{
    kubectl delete deployments --all 
    kubectl delete services --all 
    kubectl delete pods --all 
    kubectl delete pvc --all 
    kubectl delete pv --all 
}

start_minikube()
{
    eval $(minikube docker-env)   
    sudo chmod 666 /var/run/docker.sock 
    minikube start --driver=docker  
}

enable_addons()
{
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

build_images()
{
    docker build srcs/nginx -t nginx:vscabell
}

apply_config_files()
{
    kubectl apply -f srcs/k8s/metallb.yaml
    kubectl apply -f srcs/k8s/nginx.yaml
    # kubectl apply -f srcs/k8s/mysql.yaml
    # kubectl apply -f srcs/k8s/phpmyadmin.yaml
    # kubectl apply -f srcs/k8s/wordpress.yaml
}

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
    build_images
    apply_config_files
fi