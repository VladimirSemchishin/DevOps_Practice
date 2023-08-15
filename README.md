# DevOps_Practice
Здесь краткие записи итогов минипроектов моего обучения Docker и Docker Compose. 


### ToDo.
Есть проект - таск менеджер todo. Сначала я создал Dockerfile, который создает контейнер основе образа node:18-alpine, делает рабочей директорий /app, переносит все файлы из текущей директории, запускает файл src/index.js и открывает 3000 порт. Вот [Dockerfile1](https://github.com/VladimirSemchishin/MyDocker/blob/main/Dockerfile1 "Ссылка на Dockerfile1")

После чего для возможности сохранения данных, был смонтирован именнованный том с привязкой к хосту. На этом этапе БД была реализована на SQLite, то есть один файл.

Для возможности масштабироваться необходимо перейти на ядро MySQL, соответсвенно необходимо создать отдельный контейнер с БД (mysql) и подружить его с контейнером приложения (app). Чтобы не делать это все в ручную (создавать сеть, контейнеры, пробрасывать порты и тд...) создан [docker-compose.yaml](https://github.com/VladimirSemchishin/MyDocker/blob/main/docker-compose.yaml "Ссылка на docker-compose.yaml") 

### Шифровщик теста.
Суть проекта заключается в том чтобы пройтись по каждой из тем на практике: Слои, Multi-stage, Параллелизм, Bild targets,Mounts, Bild arguments, экспорт файлов бинарников и Test. Вот [Dockerfile2](https://github.com/VladimirSemchishin/MyDocker/blob/main/Dockerfile2 "Ссылка на Dockerfile2")
