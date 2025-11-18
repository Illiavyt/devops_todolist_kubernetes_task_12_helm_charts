#!/bin/bash
kubectl apply -f .infrastructure/mysql/ns.yml
kubectl apply -f .infrastructure/mysql/configMap.yml
kubectl apply -f .infrastructure/mysql/secret.yml
kubectl apply -f .infrastructure/mysql/service.yml
kubectl apply -f .infrastructure/mysql/statefulSet.yml

kubectl apply -f .infrastructure/app/ns.yml
kubectl apply -f .infrastructure/app/pv.yml
kubectl apply -f .infrastructure/app/pvc.yml
kubectl apply -f .infrastructure/app/secret.yml
kubectl apply -f .infrastructure/app/configMap.yml
kubectl apply -f .infrastructure/app/clusterIp.yml
kubectl apply -f .infrastructure/app/nodeport.yml
kubectl apply -f .infrastructure/app/hpa.yml
kubectl apply -f .infrastructure/app/deployment.yml

# Install Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
# kubectl apply -f .infrastructure/ingress/ingress.yml


# 1. Створюємо namespace (якщо не існує)
kubectl create namespace mysql

# 2. Деплойтимо підчарт mysql
helm upgrade --install mysql ./helm-charts/kube2py/charts/mysql -n mysql

# 3. Створюємо namespace для todoapp (якщо потрібно)
kubectl create namespace todoapp

# 4. Деплойтимо todoapp
helm upgrade --install todoapp ./helm-charts/kube2py/charts/todoapp -n todoapp

# 5. Перевіряємо всі ресурси і виводимо в output.log
kubectl get all,cm,secret,ing -A > output.log
