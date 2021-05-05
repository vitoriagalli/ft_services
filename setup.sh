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
    minikube start --driver=docker  
}

enable_dashboard()
{
    minikube addons enable dashboard
}

install_metallb()
{
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
    kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
}

build_images()
{
    docker build srcs/nginx -t nginx:vscabell
}

apply_config_files()
{
    kubectl apply -f srcs/k8s/
}

if [ "$1" == "apply" ]; then
    clean_environment
    apply_config_files
else
    delete_environment
    start_minikube
    # install_metallb
    # enable_dashboard
    # build_images
    apply_config_files
fi