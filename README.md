# DevOps_Practice
Здесь краткие записи итогов минипроектов моего обучения Docker и Docker Compose. 

## Docker

### ToDo.
Есть проект - таск менеджер todo. Сначала я создал Dockerfile, который создает контейнер основе образа node:18-alpine, делает рабочей директорий /app, переносит все файлы из текущей директории, запускает файл src/index.js и открывает 3000 порт. Вот [Dockerfile1](https://github.com/VladimirSemchishin/MyDocker/blob/main/Dockerfile1 "Ссылка на Dockerfile1")

После чего для возможности сохранения данных, был смонтирован именнованный том с привязкой к хосту. На этом этапе БД была реализована на SQLite, то есть один файл.

Для возможности масштабироваться необходимо перейти на ядро MySQL, соответсвенно необходимо создать отдельный контейнер с БД (mysql) и подружить его с контейнером приложения (app). Чтобы не делать это все в ручную (создавать сеть, контейнеры, пробрасывать порты и тд...) создан [docker-compose.yaml](https://github.com/VladimirSemchishin/MyDocker/blob/main/docker-compose.yaml "Ссылка на docker-compose.yaml") 

### Шифровщик теста.
Суть проекта заключается в том чтобы пройтись по каждой из тем на практике: Слои, Multi-stage, Параллелизм, Bild targets,Mounts, Bild arguments, экспорт файлов бинарников и Test. Вот [Dockerfile2](https://github.com/VladimirSemchishin/MyDocker/blob/main/Dockerfile2 "Ссылка на Dockerfile2")


## Terraform
Создание мультизонального кластера K8s через провайдера YandexCloud в соответсвии с best practices. Все значения которые могут изменяться описаны переменными, если есть части повторяющегося кода, они были переписаны с использование функций terraforn для работы с списками (for_each, lookup и flatten). Хранения файла состояния реализовано через хранилище s3
Реализовано отдельное описание частей:
-- network:  
+ locals.tf          - локальные переменные
- main.tf            - инициализация и подключение провайдера
* outputs.tf         - вывод network_id, sg_internal, sg_k8s_master, sg_k8s_worker
            * security_group.tf - права для internal (связуещего мастеров и воркеров), мастеров и воркеров
            * static-ip.tf      - определение статических ip, в инфраструктуре он один, но через цикл реализована возможность использования большего количесва.
            * storage.key       - логин и пороль для сервисного акк, реализовано через шаблон для aws, по этому для запуска необходима соответвующая утилита.
            * terraform.tfvars  - значение переменных
            * variables.tf      - объявление переменных
            * vpc.tf            - описание сети и подсетей 

-- k8s:     
            * cluster.tf         - описание кластера k8s
            * data.tf            - реализована возможность брать данные извне директории манифеста (чтобы из папки k8s можно было обратиться к переменным в папке network)
            * locals.tf          - локальные пременные (первая для сокарщения пути обращения к другим файлам через data. ,а вторая для реализации правильного вывода id с привязкой к зоне, для описания воркеров)
            * main.tf            - инициация и подключение провайдера
            * node_group.tf      - описание групп узлов в кластере
            * service_account.tf - создание сервисного акк и назначение ролей
            * storage.key        - лог и пороль сервисного акк
            * terraform.tfvars   - значение пременных
            * variables.tf       - объявление переменных
[Директория проекта](https://github.com/VladimirSemchishin/DevOps_Practice/tree/main/Terraform_start/learn-terraform-yandex-cloud-bestpractices "Ссылка на директорию этого проекта")
