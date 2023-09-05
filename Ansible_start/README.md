# Ansible 

## Inventory

Inventory файл - файл в котором лежат адреса серверов, с которыми может взаимодействовать хост при помощи Ansible 

### Подключение по ssh

Синтаксис:

(hosts.txt) - имя файла 

`target1 ansible_host=51.250.10.206 ansible_user=target1 ansible_ssh_private_key_file=/home/controller/.ssh/id_rsa`

Псевдоним-для-ansible       адрес-подключаемой-машины      имя-пользователя-в-этой-вм      место-расположения-приват.-ключа-ssh

Для применения этого файла: `$ansible target1 -m ping -i hosts.txt`

### config file

[defaults]
`host_key_checking = false`                                #чтобы не запрашивал согласия при новом ip адресе (отпечаток)
`inventory        = ./project/hosts.txt`        #чтобы инвертори файл не прописывать через -i hosts.txt 

Чтобы это сделать нужно создать файл `ansible.cfg` с данным содержимым 

### Синтаксис

(hosts.txt) 

#можно просто как адрес
`mail.example.com`

#объединение в группу

`[webservers]`
`foo.example.com`
`bar.example.com[prodct]`

`[dbservers]`
`one.example.com`
`two.example.com`
`three.example.com`

Ansible создает две группы по умолчанию: allи ungrouped. Группа allсодержит каждый хост. В группу ungroupedвходят все хосты, у которых нет другой группы, кроме all. Например: mail.example.comпринадлежит группе allи ungroupedгруппе; хост two.example.comпринадлежит группе allи dbserversгруппе

#Чтобы не прописывать адрес, можно сделать группу, которая будет включать другие группы
`[project:children]`
`webservers`
`dbservers`

#Ввод переменных, чтобы не дублировать одинаковые записи (при помощи [prod_servers:vars], где записываются используемые и повторяющиеся переменные)
`[prod_servers]`
#`target1 ansible_host=51.250.10.206 ansible_user=target1 ansible_ssh_private_key_file=/home/controller/.ssh/id_rsa`
#`target2 ansible_host=51.250.10.206 ansible_user=target2 ansible_ssh_private_key_file=/home/controller/.ssh/id_rsa`

`target1 ansible_host=51.250.10.206 ansible_user=target1`
`target2 ansible_host=51.250.10.206 ansible_user=target2`

`[prod_servers:vars]`
`ansible_ssh_private_key_file=/home/controller/.ssh/id_rsa` 

## Ad-Hoc команды

Это команды которые можно использовать в ansible через консоль (graph выдаст график)

Вывод информации обо всех хостах, работает как скрипт инвентаризации.
`ansible-inventory --graph`
`ansible-inventory --list`

Вывод всей информации о сервере (вторым параметром указывается группа)
`ansible target1 -m setup`
`ansible all -m setup`

Внутри этого вывода хранятся переменные которые можно использовать в playbook

Запуск shell команд на серверах
`ansible all -m shell -a "ls ../../etc"`
`ansible all -m command -a "ls ../../etc"`   #тоже самое но нельзя исп < > | &

Копирование файлов с хоста на ВМ (на это этапе уже есть ansible.cfg, по этой причине не указывается -i)
`ansible all -m copy -a "src=privet.txt dest=/home mode=777" -b`     # -b это флаг для указания прав супер пользователя (типо sudo)

Удаление файлов с связанных ВМ
`ansible all -m file -a "path=/home/privet.txt state=absent" -b`

Скачивание из интернета файлов на ВМ
`ansible all -m get_url -a "url=https://myite/file.txt dest=./home/file-from-www" -b`

Установка пакетов (но перед этим должен быть установлен пакет epel-release в соотв с докой Fedora wiki)
`ansible all -m yum -a "name=stress state=installed" -b` 

Запуск сервиса apache
`ansible all -m ansible.builtin.service -a "name=httpd state=started " -b`

Дебагинг, в зависимости от того сколько v указать от 1 до 5 выдает объем инф. что происходит
`ansible all -m shell -a "ls /" -vvvv`

Чтобы узнать инфу по команде нужно просто вбить в гугл, например: `ansible resource` и выдаст ссылку на доку в которой расказано вообще все что нужно для работы.

## Правила формата YAML

Расширение .yml по сути формат обычного текста который описывает ключ значение, значение может быть списком. Начинается с - и каждый последующий - должен быть под предыдущим.

Начинается с --- заканчивается ...
Можно писать так как на фоото, главное соблюдать пробелы

![image-20230905120844355](/home/smvn/snap/typora/82/.config/Typora/typora-user-images/image-20230905120844355.png)

## Переменные в group_vars

В inventory file должны быть только группы адресов и сами адреса, без каких то либо переменных. Исключение, если нужна специическая переменная, но ее можно закинуть сразу в описание хоста

Было

![image-20230905142941020](/home/smvn/snap/typora/82/.config/Typora/typora-user-images/image-20230905142941020.png)

Стало

![image-20230905143047879](/home/smvn/snap/typora/82/.config/Typora/typora-user-images/image-20230905143047879.png)

А струкутра файлов, такова, что в папке  group_vars, хранятся файлы с переменными для host1 и host2 соответсвенно.

![image-20230905143121167](/home/smvn/snap/typora/82/.config/Typora/typora-user-images/image-20230905143121167.png)

Все переменные подтянутся и соединение по ssh будет как и прежде работать. Это в первую очередь полежно для менеджмента. 

## Простейшие PlayBook`и

### playbook1.yml

name - указвает имя
hosts - группа или конкретный хост к которому обращаться
become - запускать от имени администратора (в командной строке это было -b)

![image-20230905145030254](/home/smvn/snap/typora/82/.config/Typora/typora-user-images/image-20230905145030254.png)

Чтобы его выполнить: `$ansible-playbook playbook1.yml`
![image-20230905150128404](/home/smvn/snap/typora/82/.config/Typora/typora-user-images/image-20230905150128404.png)

### playbook2.yml 

Установка и запуск Apache
Все ыполняемые действия разделяются на tasks (задания), каждое задание начинается с -
Прописываются модули (-m) и их аргументы (-a), в данном случае модуль yum, а его атрибуты name и state. По аналогии и с запуском (enable указывает что сервис должен загружаться при загрузке)

![image-20230905151607280](/home/smvn/snap/typora/82/.config/Typora/typora-user-images/image-20230905151607280.png)

Запуск, Ansivble выведет какие шаги он сделал (tasks) с подписью (name) 
![image-20230905151705898](/home/smvn/snap/typora/82/.config/Typora/typora-user-images/image-20230905151705898.png)
