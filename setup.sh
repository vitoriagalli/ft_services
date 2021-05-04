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
    apply_config_files
fi