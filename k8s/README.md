# Kubernetes

**Kubecl** - нужен для управления k8s кластера (самая главная компонента)

**Для установки:** 

`$curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"`

`$curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"`

`$echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check`

**Для проверки:**

`$ minikube version`  - выдаст версию клиента и попытается дать ответ по серверу (но после установки его нету)

`$kubectl version --client` - узнать только версию клиента

**Minikube** - маленькая программа для создания k8s кластера состоящего из одного сервиса (масстер и ворер в одном) нужен для тестов, разработки и учебы.

**Для установки:**

`$curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64`

`$sudo install minikube-linux-amd64 /usr/local/bin/minikube`

**Для проверки:** 

`$minikube version`

## Запуск кластера 

**$ minikube start** - cоздался конфигурационный файл ~/.kube и все сертификаты и тд. в файле ~/.minikube

![image-20231011144602569](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011144602569.png)

Проверка работы кластера: `$kubectl get componentstatuses`

![image-20231011143750939](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011143750939.png)

Вывести информация по кластеру: `$kubectl cluster-info`

![image-20231011143958591](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011143958591.png)

Узнать из каких серверов состоит кластер: `$kubectl get nodes` 

![image-20231011144048056](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011144048056.png)

Остановка кластера: `$minikube stop`

![image-20231011144238322](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011144238322.png)

Удалить кластер: `$minikube delete` - можно было исп. и без остановки

![image-20231011144325046](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011144325046.png)

Параметры при создании кластера можно задавать: `$minikube start --cpus=2 --memory=1800MB --disk-size=2gb`

Так же можно подлючиться к кластеру: `$minikube ssh`

![image-20231011145717893](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011145717893.png)

## Создание Создание Docker Image, DockerHub, Запуск Docker Container

### Созднаие простого приложения на PHP

![image-20231011153000697](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011153000697.png)

![image-20231011153038246](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011153038246.png)

### Создание Dokerfile с Apache + PHP + наше приложение

![image-20231011153057665](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011153057665.png)

![image-20231011153117141](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011153117141.png)

### Создание Docker image из нашего Dokcerfile

`$docker build -t myk8sapp:v1 .`

### Создание Repository на Docker Hub

![image-20231011153209865](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011153209865.png)

### Загрузка Docker Image в наш Repository на DockerHub

Для этого нужно переименовать образ:

`$docker tag myk8sapp:v1  dvd12/kubernetes:v1` - создастся дубликат первого image 

![image-20231011154748881](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011154748881.png)

Выгрузка в DockerHub: 

`$docker push vd12/kubernetes:v1`

![image-20231011155211761](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011155211761.png)

### Тестирование нашего Docker Image на DockerHub

Теперь можно удалить образ с ПК: 

`$docker rmi 6564ee5d528f -f ` 

Запуск контейнера из образа с DockerHub:

`$docker run -it -p 1122:80 dvd12/kubernetes:v2`

## Главные объекты Kubernetes

**Container** - это не объект k8s

### Главные:

**Pod** - самый маленький и простой объект который можно создать в k8s, он состоит контейнера или нескольких

**Deployment** - он состоит из одинаковых pod-ов 

**Service** - дает доступ к подам которые бегут в deployment

**Nodees** - это сервера где все бежит

**Cluster** - объединение серверов

### Остальные

DeamonSets

StatefulSets

ReplicaSets

Secrets

PV

SVC

LoadBalancers

ConfigMaps

Vertical Pod Autoscaler

Horizontal Pod Autoscaler

...

Обычно используется 1 Pod - 1 container, чтобы делать масштабирование только нужным объектам. По этому нужно разделять на микросервисы.

Чтобы сделать Autoscaler нужны Deploument (объединение подов)

Сервис дает доступ ко всему 

![image-20231011164917676](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231011164917676.png)

### Итог:

**Pod** - объект в котором работают один или больше Containers

**Deployment** - сэт одинаковых Pods, нужен для Auto Scaling и для обновления Container Image, держит минимальное количество работающих Pods

**Service** - предоставляет доступ к Deployment через 

- ClusterIP - внутренний ip адресс который доступен только в кластере
- NodePort - на всех серверах будет открыт какой то port и через него на любом сервере можно будет достучаться до deployment 
- LoadBalancer
- ExternalName - то есть DNS имя

**Nodes** - сервера где все это работает

**Cluste**r - логическое объединение nodes

## Создание и управление **Pods**

Что должно получиться 

![image-20231012094226404](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012094226404.png)

Я делаю через YC, для этого я зашел в свой кабинет и создал кластер и 2 nodes. После чего я 

