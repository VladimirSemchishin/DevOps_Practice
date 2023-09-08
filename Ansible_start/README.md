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

### playbook3.yml

Развертывание сайта 
Тут из нового используем переменные, они объявляются блоком `vars:` (в примере переменным присваиваются адреса источника и назначения) позже они используются в модуле `copy:`  атрибутам src и dest дают значения переменных (через `{{...}}` )
Блок `handlers:` описывает что нужно сделать, если на его ключевое слово приходит сигнал о выполнении этой задачи.
В данном примере перезапуск произойдет только если изменятся файлы сайта (скопированное на ВМ в /var/www/html/)

![image-20230905171227572](/home/smvn/snap/typora/82/.config/Typora/typora-user-images/image-20230905171227572.png)

## Переменные - Debug Set_fact, Register

Чтобы вывести информацию нужен блок `debug:` его модули `var:` и `msg:` для вывода переменной или текста, чтобы вставить в текс переменную можно исп. `{{}}` 
Так же есть уже созданные переенные (показывающие конфигурацию ВМ), для их отображения: `ansible all -m setup` в выводе этой команды все переменные, которые можно использовать для вывода в своих playbook. Но вывод переменной может быть большим, по этому можно обращаться к ее сущностям (переменная может быть списком) через точку (`results.stdout`)
В случае когда выполняется команда (в примере uptime) она не будет автоматом выводится (ее результат), по этому необходимо использовать `register:` это ключевое слово для создания переменной из выходных задач ansible (по этому как раз она и записывается ровно под подулем `shell:`)

![image-20230906151546140](/home/smvn/snap/typora/84/.config/Typora/typora-user-images/image-20230906151546140.png)

Исполнение playbook4.yml
![image-20230906151704371](/home/smvn/snap/typora/84/.config/Typora/typora-user-images/image-20230906151704371.png)

![image-20230906151747394](/home/smvn/snap/typora/84/.config/Typora/typora-user-images/image-20230906151747394.png)

## Блоки и Условия - Block-When 

Например, если 3 сервера на котором нужно развернуть сайт, один из них ubuntu два остальных centos. Для centos команда yum, а для ubuntu apt, по этому необходимо задать условие, когда ansible_os_family (о этой переменной я узнал из `-m setup`) равна redhat нужно использовать yum, когда  debian нужно apt ( так же атрибуты `name=httpd` и `name=apache2` соответсвенно)
![image-20230906162940052](/home/smvn/snap/typora/84/.config/Typora/typora-user-images/image-20230906162940052.png)

Применение playbook5.yml
![image-20230906163120348](/home/smvn/snap/typora/84/.config/Typora/typora-user-images/image-20230906163120348.png)
![image-20230906163137843](/home/smvn/snap/typora/84/.config/Typora/typora-user-images/image-20230906163137843.png)

Видно что when используется не удобно (постоянно переписывается), значит те таски в которых он есть нужно объединить. А объединяются они через блок `block:` так же важно записывать `when:` в конце блока.
![image-20230906165640879](/home/smvn/snap/typora/84/.config/Typora/typora-user-images/image-20230906165640879.png)

Применение playbook5.yml
![image-20230906165735046](/home/smvn/snap/typora/84/.config/Typora/typora-user-images/image-20230906165735046.png)
![image-20230906165829834](/home/smvn/snap/typora/84/.config/Typora/typora-user-images/image-20230906165829834.png)

## Циклы - Loop, With_Items, Until, With_fileglob

Использование цикла `loop`
есть ключевое слово `{{ item }}` которое принимает все значения описанные в `loop` (еще вместо `loop:` можно написать with_item это ссылка на список значение, по которому нужно пройтись)

Цикл можно записать как "выполнять до тех пор пока выполняется условие" это делается через `until` (в примере  выводится новой записью буква z, -n означает без перевода строки, в файл myfile.txt и выполняется вывод этого файла в консоль, вывод задачи так же присваивается переменной output, устанолено максимальное кол-во попыток 10 с временем на выполнение попытки 2 секунды, действие будет выполняться пока в файле не будет записано ZZZZ) 

Так же при помощи цикла можно устанавливать программки на ВМ

![
](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230908160729957.png)

Запуск playbookloop.yml
![image-20230908162333344](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230908162333344.png)
![image-20230908162355316](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230908162355316.png)

### Копирование файлов через цикл и улучшение перезагрузки сайтов после изменений

Скопировал playbook5 и переделал
Убрал дублирующееся копирование файлов и сделал перечисление триггеров (notify), а обработчик (handlers - это задачи, которые запускаются только при получении уведомления) прописал с условием `when`

Для перечисления использовал item, который принимает значения перечисленных файлов в папке, адрес до которой присвоен переменной source_folder

![image-20230908175129320](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230908175129320.png)
![image-20230908175206088](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230908175206088.png)
![image-20230908175234192](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230908175234192.png)
![image-20230908175400735](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230908175400735.png)
![image-20230908175424431](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230908175424431.png)

Копирование другим способом.
Использование специального плагина (он входит в ansible-core). Тоже самое просто короче пишется

![image-20230908180724297](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230908180724297.png)
