#!/usr/bin/env bash

backupDir="./backup/"

if [[ -f ~/.kube/config ]]; then
    mv ~/.kube/config ~/.kube/config.bak
fi

if [[ ! -d $backupDir ]]; then
    mkdir -p $backupDir
fi

cp ./config ~/.kube/config

namespaces=(
"coding-base"
"tool"
"coding-api-docs-dev"
"coding-dev"
"coding-testing-dev"
"files-dev"
"search"
"wiki-dev"
"cci-test"
"coding-api-docs-test"
"coding-home-page"
"coding-operation"
"coding-test"
"coding-testing-test"
"files-test"
"micro-frontend-test"
"wiki-test"
)

for name in ${namespaces[@]}
do

kubectl get deployment --namespace="$name" -o yaml > "$backupDir""$name"_deployment.yaml

echo "$name" deployment backup success!!!

kubectl get ingress --namespace="$name" -o yaml > "$backupDir""$name"_ingress.yaml

echo "$name" ingress backup success!!!

done


