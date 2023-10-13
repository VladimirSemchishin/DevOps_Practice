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

## 8. Создание и управление **Pods**

Что должно получиться 

![image-20231012094226404](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012094226404.png)

Я делаю через YC, для этого я зашел в свой кабинет и создал кластер и в нем 2 nodes. 

Добавил учетные данные в конфигурационный файл kubectl 

`$yc managed-kubernetes cluster get-credentials test-k8s-cluster --external`

он находится по адресу: $HOME/.kube/config

Для проверки конфигурации после добавления учетных данных:

`$kubectl config view`

Итог:

![image-20231012141348817](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012141348817.png)

Запуск первого пода. Создадим image, из него контейнер, который будет бежать в поде.

Используйте следующий синтаксис для выполнения команд `kubectl` в терминале:

```shell
kubectl [command] [TYPE] [NAME] [flags]
```

### Создание пода

`$kubectl run hello --image=httpd:latest --port=80`

где hello - это имя пода, --image - образ (его он может взять с пк или dockerhub)

![image-20231012144248737](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012144248737.png)

### Удаление пода

`$kubectl delete hello`

![image-20231012144331675](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012144331675.png)

Полечение полной информации о pod

`$kubectl describe pods hello`

![image-20231012144544118](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012144544118.png)

Как видно, под сейчас бежит на node - cl164r9u1m42kmu8oge4-unof

### Запуск комад внутри pod

Узнать время на pod

`$kubectl exec hello date`

`$kubectl exec -it hello sh` - запустит shell интерактивно

![image-20231012145401824](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012145401824.png)

Просмотр логов

`$ubectl logs hello`

![image-20231012145518281](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012145518281.png)

Чтобы перенаправить порт и увидеть страничку пода нужно

`$kubectl port-forward hello 7788:80`

![image-20231012145804804](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012145804804.png)

### Создание и запуск подов через config файл (манифест)

Минимальное количество строчек для запуска манифеста

![image-20231012152159986](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012152159986.png)

Конкретный формат поля-объекта `spec` зависит от типа объекта Kubernetes и содержит вложенные поля, предназначенные только для используемого объекта. В [справочнике API Kubernetes](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.28/) можно найти формат спецификации любого объекта Kubernetes. Например, формат `spec` для объекта Pod находится в [ядре PodSpec v1](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.28/#podspec-v1-core), а формат `spec` для Deployment — в [DeploymentSpec v1 apps](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.28/#deploymentspec-v1-apps).

Для созданиния необх вып. команду apply

`$kubectl apply -f pod-myweb-ver1.yaml`

![image-20231012152742275](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012152742275.png)

Откроем порт

![image-20231012152935154](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012152935154.png)

Чтобы внести изменения, под необходимо удалить (delete) и занаво создать на основе манифеста с изменениями

`$kubectl delete -f pod-myweb-ver1.yaml`

И занаво создаю

`$kubectl apply -f pod-myweb-ver1.yaml`

После пробрасываю порт на открытый в контейнере.

`$kubectl port-forward my-web 8889:80`

Изменять файл, а после занаво сразу создавать контейнер нельзя. Исключение - name  и image контейнера. И то в консоли нужно приостанаваливать (ctrl+c) процесс, а не убивать (ctrl+z)

### Labels

это пары ключ/значение, которые прикрепляются к объектам, таким как pod. Могут быть прикреплены к объектам в момент создания и впоследствии добавляться и изменяться в любое время. Для каждого объекта может быть определен набор меток ключ/значение. Каждый ключ должен быть уникальным для данного объекта.

![image-20231012185851210](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012185851210.png)

Чтобы запустить 2 контейнера в 1 pod необходимо просто продублировать:

![image-20231012190906678](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012190906678.png)

Чтобы получить к ним доступ нужно по аналогии:

`$kubectl port-forward my-app  8890:80` - сервер nginx работает

`$kubectl port-forward my-app  8890:8080` - работает tomcat 

**Если сервер** умирает, то поды тоже умирают, не востанавливаются, их необходимо занаво создавать. По этой причине и создали deployment

Итоговый манифест:

![image-20231012192102751](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012192102751.png)

## 9. Создание и управление Deployment  

То что должно получиться 

![image-20231012193634185](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012193634185.png)

Проверка наличия Deployment

`$kubectl get deployments`

`$kubectl get deploy` - сокращенная версия

![image-20231012194154610](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012194154610.png)

Создание deployment

`$kubectl create deployment vladimir-depoyment --image nginx:latest`

![image-20231012194504465](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012194504465.png)

Как видно этот деплоймент создал под (в начало добавил имя дейплоймента)

Как и для пода можно посмотреть подробную информацию

`$kubectl describe deploy  vladimir-depoyment`

![image-20231012194811140](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012194811140.png)

### Scale - масштабирование

![image-20231012195141288](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012195141288.png)

Создалось дополнительно 3 пода

Так же создалась ReplicaSets

`$kubectl get rs`

![image-20231012195333479](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012195333479.png)

Если под выйдет из строя, то он тут же восстановится. Так все поды распределены по nodes.

![image-20231012195455889](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012195455889.png)

### Autoscale

`$kubectl autoscale deployment vladimir-depoyment --min=4 --max=6 --cpu-percent=80`

![image-20231012200218642](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012200218642.png)

Добавили к уже существующему deployment, (эта команда не сможет создать новый деплоймент) **hpa - horizontal pod autoscaler**

Его можно так же просмотреть

![image-20231012200514428](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012200514428.png)

### Просмотерть историю и статус всех deployment 

`$kubectl rollout history deployment/vladimir-depoyment`

![image-20231012200805910](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012200805910.png)

`$kubectl rollout status deployment/vladimir-depoyment`

![image-20231012201031797](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012201031797.png)

### Обновление в deployment, так же возврат и перемещение

обновление образа в контейнере

`$kubectl set image deployment/vladimir-depoyment container_name=httpd:latest --record`

Если deployment не удался, то вернуться к предыдущему deploy можно командой

`$kubectl rollout history deployment/vladimir-depoyment`

История выглядит следующим образом

![image-20231012202320218](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012202320218.png)

Чтобы переместиться на любой deploy из истории

`$kubectl rollout undo deployment/vladimir-depoyment --to-revision=2`

где 2 - это номер версии deploy в истории 

Если имя образа не изменяется, то deploy нужно перезагрузить

`$kubectl rollout restart deployment/vladimir-depoyment`

### Созадние deploymet через манифест

![image-20231012204931780](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012204931780.png)

Создался deploy 

![image-20231012205003612](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012205003612.png)

![image-20231012205027088](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012205027088.png)

### Создание деплоя с указанием количества реплик

В спецификации деплоя нужно указать сколько реплик нужно делать

![image-20231012205657048](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012205657048.png)

Тогда при запуске этого манифеста будет создаваться сразу 3 пода.

![image-20231012213623456](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012213623456.png)

![image-20231012213714324](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012213714324.png)

### Удаление

если поды создавались из файлов, то и уничтожать их нужно тоже через файлы

`$kubectl delete -f deployment-2-replicas.yaml`

`$kubectl delete deploy vladimir-depoyment` - этот deploy создавался в ручную

![image-20231012214037995](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012214037995.png)

### Повторение команд

![image-20231012214256487](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231012214256487.png)

## Создание и Управление - SERVICES 

Что должно получиться

![image-20231013182312041](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231013182312041.png)

Всего есть 4 вида сервисов, каждому виду соответсвует свое поведение.

**ClusterIP** - (по умолчанию) - (IP только внутри k8s Cluster) - открывает service на внутреннем IP-адресе кластера. При выборе этого значения служба становится доступной только изнутри кластера. Можно вывести службу в публичный интеренет используюя <u>ingress</u> или <u>geteway</u> 

**NodePort** - (определенный порт на всех k8s worker nodes) - выставляет service на IP-адресе каждого узла на статический порт (<u>NodePort</u>). Чтобы сделать порт узла доступным, Kubernetes устанавливает кластерный IP-адрес, так же как если бы вы запросили сервис типа: <u>ClusterIP</u>.

**LoadBalancer** -  - внешний доступ к service осуществляется с помощью внешнего балансировщика нагрузки. Kubernetes не предлагает компонент балансировки нагрузки напрямую; его необходимо предоставить, либо интегрировать кластер Kubernetes с облачным провайдером.

**ExternalName** - сопоставляет service с содержимым поля externalName (например, с именем хоста api.foo.bar.example). Это сопоставление настраивает DNS-сервер кластера на возврат CNAME-записи с таким значением внешнего имени хоста. Никакого проксирования не устанавливается.

**Для начала (повторение)**

Создание deployment

`$kubectl create deployment vova-deloy --image nginx:latest`

Создание реплик

`$kubectl scale deployment vova-deloy --replicas 3`

![image-20231013184452304](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231013184452304.png)

**Создание service --type=ClusterIP**

`$kubectl expose deployment vova-deloy --type=ClusterIP --port 80`

`$kubectl get services`  - посмотреть какие сервисы созданы

**services** можно кратко писать **svc**

![image-20231013184903622](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231013184903622.png)

Теперь если зайти на любой из воркеров (узел в кластере, а он в свою очередь развернут на ВМ, можно сравнить, ip node будет соотв ip ВМ на которой он равернут)

![image-20231013185537514](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231013185537514.png)

Как видно изнутри кластера все работет

### Удаление service

![image-20231013185829226](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231013185829226.png)

`$kubectl delete service vova-deloy`

![image-20231013185925080](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231013185925080.png)

**Создание service --type=NodePort**

`$kubectl expose deploy vova-deloy --type=NodePort --port 80`

![image-20231013190530616](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231013190530616.png)

Он создал ClusterIP по умолчанию, также создал порт 31477. Если обратиться по этому порту с воркеров внутри кластера, то попадешь на приложение.

Теперь nodes доспуны из интернета по своему ExternalIP, чтобы уго узнать нужно посмотреть подробную информацию 

`$kubectl describe nodes`

вывод будет очень большим, по этому можно искать конкретную строку :

`$kubectl describe nodes | grep ExternalIP`

![image-20231013191451788](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231013191451788.png)

**Удаление**

`$kubectl delete svc vova-deloy`

**Создание service --type=LoadBalancer**

`$kubectl expose deploy vova-deloy --type=LoadBalancer --port 80`

![image-20231013192209329](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231013192209329.png)

Как видно создался ExternalIP по которому LoadBalancer будет доступен. Если по нему перейти то будет доспуно наше приложение, которое развернуто на 3 nodes. Если обновлять они будут сменять друг друга.

![image-20231013192344574](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231013192344574.png)

**Удалим все** 

`$kubectl delete svc vova-deloy`

`$kubectl delete deploy vova-deloy`

### Создание манифеста
