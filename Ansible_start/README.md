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
](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908160729957.png)

Запуск playbookloop.yml
![image-20230908162333344](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908162333344.png)
![image-20230908162355316](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908162355316.png)

### Копирование файлов через цикл и улучшение перезагрузки сайтов после изменений

Скопировал playbook5 и переделал
Убрал дублирующееся копирование файлов и сделал перечисление триггеров (notify), а обработчик (handlers - это задачи, которые запускаются только при получении уведомления) прописал с условием `when`

Для перечисления использовал item, который принимает значения перечисленных файлов в папке, адрес до которой присвоен переменной source_folder

![image-20230908175129320](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908175129320.png)
![image-20230908175206088](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908175206088.png)
![image-20230908175234192](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908175234192.png)
![image-20230908175400735](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908175400735.png)
![image-20230908175424431](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908175424431.png)

Копирование другим способом.
Использование специального плагина (он входит в ansible-core). Тоже самое просто короче пишется

![image-20230908180724297](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908180724297.png)

## Шаблоны Jinja Temlate

Ansible Temlate - это шаблоны, они пишутся в формате jinja2 (`.j2`). Если нужно генерировать файлы которые немного отличаются (переменными которые будут внутри этого файла, например index.html) Для этого определить переменные которые будут использоваться в index.html
Возьмем переменную которая на всех хостах разная (из `ansible all -m setup`) `ansible_hostname`, `ansible_fqdn` , `ansible_eth0.ipv4.address`, `owner` (эта переменная создана и взята из inventory файла)

Чтобы создать шаблон, переходим в директорию с нужным файлом и переименовываем его в формат `.j2` после чего в этом файле нужно указать переменные в привычном формате через `{{ }}` (например `{{ owner }}`)

В playbook6.yml нужно убрать ранее написанное копирование `index.html` (которое было через модуль `copy:` c использованием цикла loop) нужно замнить дургим модулем (`templte:`) он такой же как copy, но отличается тем, что проверяет файлы на наличие переменных, если они там есть то производится замена переменной на ее значение. 

![image-20230908182944118](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908182944118.png)

Так будет выглядеть index.j2
![image-20230908191543362](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908191543362.png)

Так будет выглядеть playbook6.yml
![image-20230908224741282](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908224741282.png)

## Создание ролей Roles

Необходимо создать попку `roles`  (`mkdir roles`) после чего выполнить команду:
`$ansible-gelaxy init deploy_apache_web` 
(где deploy_apache_web это название роли которое придумывается самостоятельно)
Создастя директория с этим именем, структура автоматически создается следующая:
![image-20230908225410609](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908225410609.png)

Созданные файлы изначально пустые

- **defaults**/main.yml - переменные по умолчанию для роли. Эти переменные имеют самый низкий приоритет среди всех доступных переменных и могут быть легко переопределены любой другой переменной, включая переменные инвентаризации.
- **files**/main.yml -файлы, которые роль развертывает.
- **handlers**/main.yml - обработчики, которые могут использоваться как в рамках этой роли, так и вне ее.
- **meta**/main.yml - метаданные для роли, включая зависимости от роли и необязательные метаданные Galaxy, такие как поддерживаемые платформы.
- **tasks**/main.yml - основной список задач, выполняемых ролью.
- **templates**/main.yml - шаблоны, которые развертывает роль.
- **tests** - для пробного inventory
- **vars**/main.yml - другие переменные для роли

Суть заключается в том, чтобы раскидать уже созданные playbook6.yml по этим папкам (некоторые не будут использоваться)

Сейчас playbook6.yml выглядит следующим образом:
![image-20230908230738485](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908230738485.png)
![image-20230908230807171](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908230807171.png)
![image-20230908230841537](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908230841537.png)
![image-20230908230909357](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908230909357.png)
![image-20230908230949960](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908230949960.png)
![image-20230908231015900](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908231015900.png)

Переносим сначала файлы которые просто копируются (file1-4), затем генерируемые файлы (index.j2)
![image-20230908232925617](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908232925617.png)

Следующим шагом переносим в `roles/deploy_apache_web/defaults/main.yml` переменные, поскольку по дефолту ресурсный файл будет определен, нужно перенести только одну переменную.

![image-20230908232712747](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908232712747.png) 

Затем переноси hendlers
![image-20230908233229597](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908233229597.png)

Далее переносим tasks
Не забывая поправить (убрать `source_folder` из блока `temlates` потому что по дефолту обращаться будет к директории `temlates`, а копировать файлы будет из директории `files`)

![image-20230908235436934](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908235436934.png)

И чтобы запустить все это необходим playbook7.yml (то что осталось после раскидывания от playbook6.yml с указанием роли)

![image-20230908234557032](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908234557032.png)
Но еще укажу условие при котором будет запускаться эта роль, если ansible_system это линукс
![image-20230908234921873](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908234921873.png)

В общем виде все действия были проделаны так:
![image-20230908235732408](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230908235732408.png)

## Внешние переменные --extra-vars

К примеру в файле playbook7.yml где описываются на каких хостах деплоить. Чтобы не переписывать этот файл, можно в описании хоста сделать переменную и задать ее значение по умолчанию или передать ее значение уже в консоли через `--extra-vars`

![image-20230909131447469](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230909131447469.png)

Затем при запуске плейбука указать значение для этой переменной
![image-20230909131543068](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230909131543068.png)

Возможно любое написание:

- `--extra-vars "..."`
- `--extra-var "..."`
- `-e " ..."`

Причем, если задать значение переменной таким образом, она будет иметь приоритетное значение. Т.е. если уже задано значение переменной, при запуске она примет значение `--extra-vars` (к примеру изначально в директории group_vars переменная задана MYHOST=ALL, то если задать `-e "MYHOST=host1"` playbook7.yml запустится только на 1 хосте)

## Использование Import, Include

Если использовать `import`, то ансибл пройдется по всем строкам указанного файла и если есть переменные, он их применит как будто значения были прописаны текстом а не переменной (нельзя будет изменить через переменную)

Если исп `include`, он будет применять переменные в последнюю очередь (их можно будет измменить)

Есть playbook_include.yml

![image-20230909135629280](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230909135629280.png)

Чтобы можно было использовать `include` или `import` нужно создать соответсвующие файлы .yml и расфасовать по ним этот playbook (мини версия применения roles) 
Создам файлы create_folders.yml  и create_files.yml
![image-20230909140119180](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230909140119180.png)
И перенесу в них таски по созданию файлов и директорий
![image-20230909140234711](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230909140234711.png)

![image-20230909140253978](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230909140253978.png)
Важно отметить что создастся не только файл которого ранее небыло, но и директория (secrets)

Так будет выглядеть по итогу playbook_include.yml  так же можно прописать значение переменной (перезадать ее)

![image-20230909135926836](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230909135926836.png)

## Перенаправление выполенения Task из Playbook на определенные серевера delegate_to

Чтобы запустить выполнение задачи (`tasks`) на конкретнм хосте необходимо использовать в ее плоке параметр `delegate_to:` и обратиться к хосту, тогда эта задача выполниться только на нем

Обратиться можно и к мастеру, просто обращаться к нему нужно по зарезервированному ip `127.0.0.1`

![image-20230909150013335](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230909150013335.png)
![image-20230909150038428](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230909150038428.png)
![image-20230909152741705](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230909152741705.png)

Последние 2 блока это перезапуск воркеров,

Если требуется одновременный запуск нескольких задач в плейбуке, используйте async с параметром poll, равным 0. При установке параметра poll: 0, Ansible запускает задачу и сразу переходит к следующей, не дожидаясь результата. Каждая задача async выполняется до тех пор, пока не завершится, не завершится неудачей или не завершится по времени (выполняется дольше, чем значение async). Запуск плейбука завершается без проверки выполнения асинхронных задач.

Если вы хотите установить более длительный тайм-аут для определенной задачи в вашем плейбуке, используйте async с poll, установленным на положительное значение. Ansible по-прежнему будет блокировать следующую задачу в книге воспроизведения, ожидая, пока async-задача не завершится, не завершится неудачно или не завершится по таймауту. Однако задача завершится только в том случае, если превысит лимит таймаута, заданный параметром async.

`wait-for:` -  Ожидание условия перед продолжением. Вы можете подождать заданное время timeout, которое используется по умолчанию, если ничего не указано или указано только timeout. При этом ошибка не возникает. Ожидание, пока порт станет доступным, полезно в тех случаях, когда сервисы не сразу становятся доступными после возврата их init-скриптов

У него много параметров, но используемые в примере это:

`host`   - Разрешаемое имя хоста или IP-адрес для ожидания. (дефолтное 127.0.0.1)
`delay`  - Количество секунд ожидания перед началом опроса.
`sate`   - может принять значения `present / started / orstopped / absent / drained`  При проверке порта `started` будет проверено, что порт открыт, `stopped` будет проверено, что порт закрыт, `drained` будет проверено наличие активных соединений. При проверке наличия файла или строки поиска `present` or `started` будет проверять наличие файла или строки перед продолжением работы, `absent` будет проверять отсутствие или удаление файла.
`timeout`   -  Максимальное количество секунд ожидания (дефолт 300)

Если необходимо выполнить задачу только один раз использовать `run_once:` и пыолнится только один раз на любом воркере (если нужно на конкретном можно добавить `delegte_to:`)

![image-20230909154330851](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230909154330851.png)



## Перехват и Контроль Ошибок Error Handling

Если есть task выполнение которого не важно но важно чтобы поледующие выполнились, можно указать, что в случае ошибки нужно просто игнорировать его.
Есть playbook_errorhndling.yml
В первом таске указано, что нужно игнорировать ошибки через `ignore_errors: yes`

![image-20230910153023510](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230910153023510.png)

Запустим (таск 1 проигнорирован)

![image-20230910153519672](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230910153519672.png)

Можно приостановить выполнение тасков, если при исполнении одного из них в параметрах значение переменной прило определенное значение
Для этого нужен параметр `failed_when: " 'значение' in results.stdout "` 
где  в одинарных ковычках искомое значение при котором исполнение таска будет ошибкой
`results.stdout` - это указание переменной в которой искать значение

![image-20230910154244357](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230910154244357.png)

Результат (выполнение второго таска будет ошибкой, тк в значении переменной будет World)

![image-20230910154216959](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230910154216959.png)

Можно выполнить поиск не только по тексту но и по значению (rc - return code - код возврата 0 true 1 false)
![image-20230910154600823](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230910154600823.png)

Можно приостановить выполнение всех после первой же ошибки (таск попытается выполнить задачу на всех хостах, но послеующие таски выполнять не будет)

![image-20230910155806777](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230910155806777.png)

Результат.

![image-20230910155832558](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230910155832558.png)

## Хранение Секретов Ansible-Vault

Создать файл который будет закрыт паролем (зашифрованный)
Для этого используется `$ansible-voult create file.txt`![image-20230911135438152](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230911135438152.png)
Нужно будет ввести пароль
Чтобы просмотреть этот файл  `$ansible-voult view file.txt`
![image-20230911135515494](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230911135515494.png)
Если обычным способом попробовать, что выдаст шифр
![image-20230911135554143](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230911135554143.png)
Для nano аналогично

Чтобы изменить  `$ansible-voult edit file.txt`
Чтобы поменять пороль `$ansible-voult rekey file.txt`

Допустим есть файл `playbook_vault.yml`
![image-20230911140949406](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230911140949406.png)
Его можно польностью зашифровать `$ansible-voult encrypt file.txt`
![image-20230911141213515](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230911141213515.png)
Все функции при это playbook сохранил, его можно сохранить, но теперь просмотреть и изменить без пороля его нельзя.
Чтобы вернуть файл в незашифрованное состояние: `$ansible-voult decrypt file.txt`  (он станет обычным файлом)

Запуск зашифрованных файлов `ansible-playbook playboook_vault.yml --ask-vault-pass` Изза последнего флага он спросит пароль и если его ввести запустится выполнение плейбука
![image-20230911142050987](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230911142050987.png)

Указать пароль для decrypt можно через файл: `ansible-playbook playboook_vault.yml --vault-password-file pass.txt`
![image-20230911142402572](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230911142402572.png)

Чтобы не шифровать весь файл, можно зашифровать только строку с паролем. `Для этого $ansible-vault encrypt_string`
![image-20230911143336757](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230911143336757.png)

И вставить зашифрованный вариант пароля в playbook
![image-20230911143424700](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230911143424700.png)

Тоже создание пароля но в одну строку: `$echo -n "password" | ansible-vault encrypt_string`

![image-20230911143809083](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230911143809083.png)

Если применяется зашифрованная переменная, то при запуске плайбука ее нужно расшифровать, так же как если бы был зашифрован весь файл (запросить вопрос пароля): `$ansible-playbook playboook_vault.yml --ask-vault-pass`
Так же если используется шифрование нескольких переменных, то нужно чтобы у них был один и тот же пароль.
![image-20230911144345116](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230911144345116.png)

Иначе (переменная так и запишится шифром и выдаст ошибку)
![image-20230911144116794](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230911144116794.png)

Кратко.

![image-20230911144420850](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/Ansible_start/image/image-20230911144420850.png)
