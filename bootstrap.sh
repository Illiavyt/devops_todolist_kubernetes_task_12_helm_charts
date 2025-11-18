#!/bin/bash

# Створення Kind кластера (якщо ще немає)
kind create cluster --name mycluster

# Зняття taint'ів з нодів (щоб дозволити scheduling)
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# Встановлення todoapp з dependency mysql через Helm
helm dependency update ./helm-charts/todoapp
helm upgrade --install todoapp ./helm-charts/todoapp -n todoapp --create-namespace

# Встановлення Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
