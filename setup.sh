#!/bin/sh

minikube stop
# sleep 3
minikube delete
# sleep 3
minikube start --vm-driver=virtualbox --cpus=4 --memory=4G --disk-size=50G
minikube ssh 'sudo mkdir /mnt/influxdb; sudo chmod 777 /mnt/influxdb'

#Установка minikube и metallb
eval $(minikube docker-env)

docker pull metallb/speaker:v0.8.2
docker pull metallb/controller:v0.8.2

minikube addons enable metallb
minikube addons enable metrics-server
# minikube addons list
kubectl apply -f ./srcs/configmap.yaml

#Установка nginx
docker build -t nginx_image ./srcs/nginx
kubectl apply -f ./srcs/nginx/nginx.yaml

#Установка my_sql
docker build -t mysql_image ./srcs/my_sql
kubectl apply -f ./srcs/my_sql/my_sql.yaml

#Установка wp
docker build -t wordpress_image ./srcs/wordpress
kubectl apply -f ./srcs/wordpress/wordpress.yaml

#Установка phpmyadmin
docker build -t phpmyadmin_image ./srcs/phpmyadmin
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml

#Установка ftps
docker build -t ftps_image ./srcs/ftps
kubectl apply -f ./srcs/ftps/ftps.yaml

#Установка influxdb
docker build -t influxdb_image srcs/influxdb
kubectl apply -f ./srcs/influxdb/influxdb.yaml

#Установка grafana
docker build -t grafana_image srcs/grafana
kubectl apply -f ./srcs/grafana/grafana.yaml

#Вызов dashboard
minikube dashboard
