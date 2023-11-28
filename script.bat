#!/bin/bash
kubectl create secret generic mysql-root-password --from-literal=MYSQL_ROOT_PASSWORD=2322000@Vtt

D:

cd D:\MyHelmChart\my-demo-helm-chart\charts

helm install mysql-replicated-release mysql-replicated-chart

timeout /t 300 /nobreak

istioctl install --set profile=demo -y

timeout /t 60 /nobreak

kubectl label namespace default istio-injection=enabled

cd D:\MyHelmChart\my-demo-helm-chart

helmfile -e multiple sync

timeout /t 60 /nobreak

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml