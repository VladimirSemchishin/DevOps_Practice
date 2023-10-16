# DOKER

## Главные основы DockerКак инсталировать 

Docker - это мини виртуальные машины  

**Docker Components**

- Docker Engine - это утилита докера установленная на пк, через нее можно выполнять команды (для проверки ее наличия `$docker -v`)
- Docker Container - запущенный образ (image)
- Docker Image - описание контенера 
- Dockerfile - описание image

### Как иснталлировать Docker

`sudo apt update` - обновить ВМ
sudo apt install apt-transport-https -  пакет дополнение для возможности использовать репозитории по https (с 1.5 уже есть в apt)

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -` - скачивание и установка ключа

![image-20231001121958018](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231001121958018.png)

`sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"` -  скачивать только стабильные версии (добавили репозиторий)

`sudo apt update` -  еще раз обновить 

`sudo apt install docker-ce` - команда установки докера

`sudo systemctl status docker` - посмотерть что Docker Engine работает 

![image-20231001122519836](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231001122519836.png)

`sudo usermod -aG docker $USER` -  подификация юзера, чтобы можно было запускать команды докера без sudo (точнее добавляем юзера в группу docker, после чего не нужно исп. sudo)

### Важные команды 

`docker images` - просмотреть какие image вообще есть на ВМ

`docker search tomcat` - поиск существующих образов в DockerHub (это альтернатива тому, чтобы зайти на сайт DockerHub)

`docker ps` - посмотреть только запущенные контейнеры 

`docker ps -a` - посмотреть вообще все существующие контейнеры (запущенные и остановленные)

`docker pull tomcat` - скачать образ и ничего не делать 

`ip address` - узнать ip адресс

`docker run -it -p 1234:8080 tomcat` - запустить контейнер на основе образа tomcat  `-it` интерактивно (до окончания процесса командная строка будет недоступна) и `-p` переопределить порты (изначатльно tomcat, если не переопределять порты будет отвечать на порту 8080, но мы хотим чтобы он отвечал на порту 1234) До этого контейнера можно достучаться так публичный_ip:1234 `http://158.160.114.136:1234/`

`docker run -d -p 1234:8080 tomcat` - запустить контейнер аналогично только на бэкнраунде (командная строка будет доступна) по выполнению он выдаст идентификатор бегущего контейнера

![image-20231001130300421](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231001130300421.png)

`docker run -d -p 12345:80 nginx` - установит и запустит контейнер если небыл скачен образ (важно знать изначально на каком порту будет бежать процесс)

`docker rmi hello-world` - удалит образ (remove image) если нет запущенных на его основе контейнеров

`docker rm 69cf50235653` - удалить контейнер 

![image-20231001133127359](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231001133127359.png)

`docker build -t vova:v1 .`   - создание образа на основе Dockerfile. `-t` добавляет тэг, в данном случае это `v1` (если не использовать будет всегда latest), а имя образа `vova`  

![image-20231001134100238](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231001134100238.png)

![image-20231001134246549](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231001134246549.png)

`docker run -d -p 7777:80 vova:v1`  - создании контейнера обязательно стоит указывать версию образар, иначе не запустится

`docker tag vova:v1 vova:copy` - переименовать тэг (по факту создастся дубликат)

![image-20231001141300363](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231001141300363.png)

`docker exec -it 3f0e6b33d825 /bin/bash` - войти в контейнер (внутри него можно что то изменить)

![image-20231001141317628](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231001141317628.png)

`docker commit 3f0e6b33d825 vova:v2` - создать на основе контейнера образ (для этого нужен id измененного контенера 3f0e6b33d825)

![image-20231001141903599](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231001141903599.png)

`docker run -d -p 888:80 vova:v2` - создать контейнер, на основе нового образа (образ на основе измененного контейнера)



### Как использовать Docker Image

`docker pull tomcat` - скачать образ и ничего не делать 

![image-20231001124456570](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231001124456570.png)

### Как запускать Docker Container

### Что такое Dockerfile

### Что такое DockerHub

это место откуда Docker может взять image для создания контейнера. (типо github но для образов контейнеров)



### Как создавать Docker Image из Dockerfile

### Как создавать обновленный Docker Image из Docker Container
