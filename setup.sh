#! /bin/bash

start_environment()
{
    echo ""
    echo -e "\033[1mStart minikube...\033[0m"

    sudo chmod 666 /var/run/docker.sock && \
    minikube --cpus=2 --memory 2200 start --driver=docker && \
    minikube addons enable storage-provisioner && \
    minikube addons enable metrics-server && \
    minikube addons enable dashboard && \
    minikube addons enable ingress

    if [ $? -ne 0 ]; then
        echo "Error"
        exit
    fi
}

delete_environment()
{
    echo ""
    echo -e "\033[1mDelete minikube...\033[0m"

    minikube delete && \
    rm -rf ~/.kube/config

    if [ $? -ne 0 ]; then
        echo "Error"
        exit
    fi
}

apply_config()
{
    echo ""
    echo -e "\033[1mApply configuration files...\033[0m"

    kubectl apply -f srcs/k8s/metallb.yaml && \
    kubectl apply -f srcs/k8s/nginx.yaml && \
    kubectl apply -f srcs/k8s/ftps.yaml && \
    kubectl apply -f srcs/k8s/mysql.yaml && \
    kubectl apply -f srcs/k8s/phpmyadmin.yaml && \
    kubectl apply -f srcs/k8s/wordpress.yaml && \
    kubectl apply -f srcs/k8s/grafana.yaml && \
    kubectl apply -f srcs/k8s/influxdb.yaml

    if [ $? -ne 0 ]; then
        echo "Error"
        exit
    fi
}

clean_config()
{
    echo ""
    echo -e "\033[1mClean configuration files...\033[0m"

    kubectl delete -f srcs/k8s/metallb.yaml && \
    kubectl delete -f srcs/k8s/nginx.yaml && \
    kubectl delete -f srcs/k8s/ftps.yaml && \
    kubectl delete -f srcs/k8s/mysql.yaml && \
    kubectl delete -f srcs/k8s/phpmyadmin.yaml && \
    kubectl delete -f srcs/k8s/wordpress.yaml && \
    kubectl delete -f srcs/k8s/grafana.yaml && \
    kubectl delete -f srcs/k8s/influxdb.yaml

    if [ $? -ne 0 ]; then
        echo "Error"
        exit
    fi
}

build_images()
{
    echo ""
    echo -e "\033[1mBuild images...\033[0m"

    echo -n "Nginx image " && \
    docker build srcs/nginx -t nginx:vscabell >> log_setup.txt && \
    echo "created" && \

    echo -n "FTPS image " && \
    docker build srcs/ftps -t ftps:vscabell >> log_setup.txt && \
    echo "created" && \

    echo -n "MySQL image " && \
    docker build srcs/mysql -t mysql:vscabell >> log_setup.txt && \
    echo "created" && \

    echo -n "PhpMyAdmin image " && \
    docker build srcs/phpmyadmin -t phpmyadmin:vscabell >> log_setup.txt && \
    echo "created" && \

    echo -n "Wordpress image " && \
    docker build srcs/wordpress -t wordpress:vscabell >> log_setup.txt && \
    echo "created" && \

    echo -n "Grafana image " && \
    docker build srcs/grafana -t grafana:vscabell >> log_setup.txt && \
    echo "created" && \

    echo -n "InfluxDB image " && \
    docker build srcs/influxdb -t influxdb:vscabell >> log_setup.txt
    echo "created" && \

    if [ $? -ne 0 ]; then
        echo "Error"
        exit
    fi
}

clean_images()
{
    echo ""
    echo -e "\033[1mClean images...\033[0m"

    docker stop $(docker ps -aq --filter name=k8s) && \
    docker rm $(docker ps -aq --filter name=k8s) && \
    docker rmi -f nginx:vscabell && \
    docker rmi -f ftps:vscabell && \
    docker rmi -f mysql:vscabell && \
    docker rmi -f phpmyadmin:vscabell && \
    docker rmi -f wordpress:vscabell && \
    docker rmi -f grafana:vscabell && \
    docker rmi -f influxdb:vscabell

    if [ $? -ne 0 ]; then
        echo "Error"
        exit
    fi
}

install_metallb()
{
    echo ""
    echo -e "\033[1mInstall metallb...\033[0m"

    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml && \
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml && \
    kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" && \
    minikube addons enable metallb

    if [ $? -ne 0 ]; then
        echo "Error"
        exit
    fi
}

atribute_ip()
{
    echo ""
    echo -e "\033[1mAtribute IP...\033[0m"

    MINIKUBEIP=$(minikube ip) && \
    IP=${MINIKUBEIP::-1}"$((${MINIKUBEIP: -1} + 1))" && \
    sed -i "s/FIRSTIP-LASTIP/$IP-$IP/g" ./srcs/k8s/metallb.yaml && \
    sed -i "s/IP/$IP/g" ./srcs/ftps/srcs/vsftpd.conf && \
    sed -i "s/CLUSTER_IP/$IP/g" ./srcs/mysql/srcs/wordpress.sql

    if [ $? -ne 0 ]; then
        echo "Error"
        exit
    fi
}


########## FT SERVICES ##########

echo "" > log_setup.txt
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
