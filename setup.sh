#! /bin/bash

install_environment()
{
    echo ""
    echo -e "\033[1mInstall environment...\033[0m"
    echo ""

    echo -e "\033[1mInstall docker...\033[0m"
    sudo apt-get update
    sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    apt-get install docker-ce docker-ce-cli containerd.io

    echo -e "\033[1mInstall minikube and kubectl...\033[0m"
    wget -q https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
    sudo install minikube-linux-amd64 /usr/local/bin/minikube && \
    https://dl.k8s.io/release/v1.21.0/bin/linux/amd64/kubectl && \
    rm -rf minikube-linux-amd64

    if [ $? -ne 0 ]; then
        echo "Error"
        exit
    fi
}

start_environment()
{
    echo ""
    echo -e "\033[1mStart minikube...\033[0m"

    sudo systemctl restart docker && \
    sudo chown $USER /var/run/docker.sock && \
    minikube --cpus=2 --memory=2500 start --driver=docker && \
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

    minikube delete
    sudo pkill nginx
    rm -rf ~/.kube
}

uninstall_environment()
{
    echo ""
    echo -e "\033[1mUninstall environment...\033[0m"
    echo ""

    echo -e "\033[1mUninstall docker...\033[0m"
    sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli
    sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce
    sudo rm -rf /var/lib/docker /etc/docker
    sudo rm /etc/apparmor.d/docker
    sudo groupdel docker
    sudo rm -rf /var/run/docker.sock

    echo -e "\033[1mUninstall minikube and kubectl...\033[0m"
    minikube delete
    rm -r ~/.kube ~/.minikube
    sudo rm /usr/local/bin/localkube /usr/local/bin/minikube
    systemctl stop '*kubelet*.mount'
    sudo docker system prune -af --volumes
    sudo rm /usr/local/bin/kubectl

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
    echo "created"

    if [ $? -ne 0 ]; then
        echo ""
        echo "Error"
        exit
    fi
}

clean_images()
{
    echo ""
    echo -e "\033[1mClean images...\033[0m"

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
    sed -i "s/CLUSTER_IP/$IP/g" ./srcs/mysql/srcs/wordpress.sql && \
    sed -i "s/IP/$IP/g" ./srcs/nginx/srcs/index.html

    if [ $? -ne 0 ]; then
        echo "Error"
        exit
    fi
}

show_services()
{
    echo -e "\033[1mOpening kubernetes web dashboard ...\033[0m"
    minikube dashboard &> /dev/null &

    MINIKUBEIP=$(minikube ip)
    IP=${MINIKUBEIP::-1}"$((${MINIKUBEIP: -1} + 1))"

    echo -e ""
    echo -e "\033[1m ~> Available Services \033[0m"
    echo -e " _____________________________________________________________"
    echo -e "|            |         |          |                           |"
    echo -e "|  SERVICE   |  USER   | PASSWORD |            URL            |"
    echo -e "|____________|_________|__________|___________________________|"
    echo -e "|            |         |          |                           |"
    echo -e "| NGINX      |         |          | http://$IP:80    |"
    echo -e "|            |         |          | https://$IP:443  |"
    echo -e "|            |         |          |                           |"
    echo -e "| WORDPRESS  |  admin  |  admin   | https://$IP:5050 |"
    echo -e "|            |  user1  |  user1   |                           |"
    echo -e "|            |  user2  |  user2   |                           |"
    echo -e "|            |  user3  |  user3   |                           |"
    echo -e "|            |         |          |                           |"
    echo -e "| PHPMYADMIN |  admin  |  admin   | https://$IP:5000 |"
    echo -e "|            |         |          |                           |"
    echo -e "| GRAFANA    |  admin  |  admin   | http://$IP:3000  |"
    echo -e "|            |         |          |                           |"
    echo -e "| FTPS       |  admin  |  admin   | ftp://$IP:21     |"
    echo -e "|____________|_________|__________|___________________________|"
    echo -e ""
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
elif [ "$1" == "config" ]; then
    kubectl delete -f srcs/k8s --recursive
    kubectl apply -f srcs/k8s --recursive
elif [ "$1" == "show" ]; then
    show_services
elif [ "$1" == "del" ]; then
    delete_environment
elif [ "$1" == "uninstall" ]; then
    uninstall_environment
else
    delete_environment
    install_environment
    start_environment
    eval $(minikube docker-env)
    install_metallb
    atribute_ip
    build_images
    apply_config
    show_services
fi
