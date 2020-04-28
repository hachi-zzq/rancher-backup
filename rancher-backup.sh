#!/usr/bin/env bash

backupDir="./backup/"

if [[ -f ~/.kube/config ]]; then
    mv ~/.kube/config ~/.kube/config.bak
fi

if [[ ! -d $backupDir ]]; then
    mkdir -p $backupDir
fi

cp ./config ~/.kube/config


namespaces=$(kubectl get namespaces | grep -v "NAME" | grep -v "cattle" | grep -v "ingress" | grep -v "kube" | awk '{print $1}')

for name in ${namespaces[@]}
do

kubectl get deployment --namespace="$name" -o yaml > "$backupDir""$name"_deployment.yaml

echo "$name" deployment backup success!!!

kubectl get ingress --namespace="$name" -o yaml > "$backupDir""$name"_ingress.yaml

echo "$name" ingress backup success!!!

done


