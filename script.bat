#!/bin/bash
kubectl create namespace myapp
kubectl create secret generic mysql-root-password --from-literal=MYSQL_ROOT_PASSWORD=2322000@Vtt -n myapp

D:

cd D:\MyHelmChart\my-demo-helm-chart\charts

helm install -n myapp mongodb bitnami/mongodb --set auth.rootPassword=2322000@Vtt -f ./mongodb-chart/mongodb-values.yaml

timeout /t 60 /nobreak

helm install -n myapp kafka-service bitnami/kafka --set persistence.size=8Mi,logPersistence.size=8Mi,volumePermissions.enabled=true,persistence.enabled=true,logPersistence.enabled=true,serviceAccount.create=false,rbac.create=false --version 26.4.3 -f ./kafka-chart/kafka-value.yaml

timeout /t 60 /nobreak

helm install -n myapp mysql-service mysql-replicated-chart

timeout /t 420 /nobreak

istioctl install --set profile=demo -y

timeout /t 60 /nobreak

kubectl label namespace myapp istio-injection=enabled

cd D:\MyHelmChart\my-demo-helm-chart

helmfile -e multiple sync
