1) docker build . -f Dockerfile-python -t docker-python
  # .  - значит что Dockerfile нужно искать в этой директории
  # -f - так мы указываем название Dockerfile который нужно найти и запустить
  # -t - это означает teg, наименование образа который соберется из указанного ранее Dockerfile

2) docker images --format "{{.Repository}}: {{.Size}}" | grep docker-python
  # --format - это нужно чтобы указать формат вывода команды images, чтобы вывелось только название рекпозитория и его размер, названия кстати беруться из таблички которая выводится при обычной команде images
  # grep     - она уже уменьшенный прошлой командой вывод, еще уменьшит до одного образа по teg, который был указан при создании 

3) docker build . -f Dockerfile-python-alpine -t docker-alpine
  # отличие от первой команды только в название исполняемого файла и tag

4) docker images --format "{{.Repository}}: {{.Size}}" | grep docker-alpine
  # смотрим размер только что созданного образа

5) docker image inspect docker-alpine
  # инспектируем созданный только что созданынй снимок

6) docker build . -f Dockerfile-python-alpine-opt -t docker-alpine-opt
  # собираем последний образ, оптимизированный