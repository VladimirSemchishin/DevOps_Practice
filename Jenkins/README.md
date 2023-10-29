# Jenkins 

## Автоматизация  CI/CD - пара слов

### CI - Continious Integration 

Это DevOps модель, в которой разработчики делают commit кода в Repository  и автоматически запускаются Build или Компиляция этого кода, после этого запускаются автоматически тесты кода: Until Test, Integratiom Test, Functionality Test

### CD - Contionios Delivery and Deployment 

Это DevOps модель, в которой разработчики делают commit кода в Repository  и автоматически запускаются Build или Компиляция этого кода, после этого запускаются автоматически тесты кода и готовый Artifact (скомпелированный код) делает Deploy в Staging, Production

### Шаги CI/CD 

Первый шаг - Commit to Soutce Control (github или bitbaket) 

Второй шаг - Build/Compile (делается компиляция на какой то триггер, например выгрузку кода в основную ветку)

Третий шаг - Test (программисты написали для своего кода )

Четвертый шаг - Deploy (код скопировать на сервер)

Пятый шаг - Провайдер или какие то свои локальные ВМ

![image-20231027122515989](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027122515989.png)

## Установка 

Я в YandexCloud создам ВМ на ubuntu, на которую поставлю Jenkins. Важно чтобы на ВМ была установлена и активна последняя версия Java.   

![image-20231027124824265](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027124824265.png)

![image-20231027124927022](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027124927022.png)

Перед установкой java обновляю ВМ

`$ sudo apt-get update`

Устанавливаю Java

`$ sudo apt-get install openjdk-17-jre`

![image-20231027125446868](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027125446868.png)

Устанавливаю Jenkins по шагам из документации:

![image-20231027125826369](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027125826369.png)

Все, проверить можно узнав его статус, поскольку он сразу начинает работать как сервис

Работает как веб-сервис, можно даже перейти по его ip на порт 8080

`$ sudo service jenkins status`

![image-20231027130129438](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027130129438.png)

![image-20231027130414468](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027130414468.png)

И необходимо 1 раз разблокировать Jenkins введя пороль, который в файле по указанному пути

![image-20231027130550059](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027130550059.png)

После дается выбор установить рекомендуемые плагины или выборочно, плагины расширяют возможности Jenkins. Если их и убирать то очень аккуратно, поскольку исчезают настройки внутри jenkins, и если они понадобятся их может не быть в таком случае.

![image-20231027132628794](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027132628794.png)

![image-20231027132939681](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027132939681.png)

После некоторых настроек мы перейдем на рабочую страницу ![image-20231027133236882](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027133236882.png)

## Администрирование Jenkins

### Обзор UI (юзер интерфейс)

![image-20231027134441668](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027134441668.png)

Все jobs при создании переходят в "Очередь сборок" где ожидают сборки, после в "Состояние сборщиков" jods выполняют build, как видно на скрине одновременно может быть 2 процесса, это можно поменять в настройках. 

Так же Jenkins управляем в этом плане и можно создавать для него воркер сервера, на которые он будет перекидывать сборки, а сам по себе может быть очень мелким сервером, которые будет только отправлять запросы.

В пользователях все подключенные юзеры

![image-20231027134910423](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027134910423.png)

В истории сборок - истрия сборок, можно посмотерть сколько сборок в какое время.

![image-20231027134957372](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027134957372.png)

И самое важное - настройки Jenkins

Прежде чем делать каие либо обновления этого сервера, необходимо сделать бэкап (например image ВМ на которой он установлен), поскольку в компании это очень важный сервер и востанавливать его может быть очень трудно.

![image-20231027135128960](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027135128960.png)







### Основные настройки Jenkins

### Обновление Jenkins

- Можно обновить ВМ через провайдера

- Можно обновить ВМ через консоль (reboot)

- А можно черезе url, добавив к адресу /restart

  ![image-20231027140758112](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027140758112.png)

  Чтобы обновить Jenkins необходимо в директорию `/usr/share/jenkins/` положить файл новый файл, переименовав прошлый на имя версии, а скаченный не трогать

  ![image-20231027141330192](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027141330192.png)

  Так же можно перезапустить Jenkins через консоль

  `$sudo service jenkins restart` - перезапуск

  

### Возврат на предыдущую версию Jenkins

Чтобы вернуться на предыдущую версию необходимо старый файл переименовать и презапустить сервис.

![image-20231027142355687](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027142355687.png)

### Создание пользователей

Это через Users в настройках

![image-20231027142913471](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027142913471.png)

## Управление Plugins

### Установка Plagins

В настрокайх переходим manage/pluginManager

Доступные обновления![image-20231027162402464](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027162402464.png)

Достпные для скачивания![image-20231027162425431](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027162425431.png)

Чтобы найти нужный плагин, можно в гугле вбить "plagins jenkins" выдаст страничку, где можно вбить в поисковиг название искомого лпагина.

![image-20231027162555820](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027162555820.png)

Их будет много, нужен самый популярный![image-20231027162656763](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027162656763.png)

В dependencies  хранятся зависимые плагины. То есть если при инсталяции выбранного, нету его зависимых плагинов, они установятся при установке основного.![image-20231027162832028](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027162832028.png)

Установлю **Credentials** плагин, этот плагин позволяет хранить учетные данные в Jenkins. для входа в тот же github![image-20231027163744800](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027163744800.png)

Он должен появиться в установленных плагинах

![image-20231027164133097](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027164133097.png)

### Установка  любой предыдущей версии Plagins

Так же в Advanced Settings можно устанаваливать вручную и настраивать прокси сервер (если нужно не раскрывать свой ip)

Установлю в ручную не самую последнюю версию Git. Если устанавилвать через Avaliable plugins то этот плагин будет всегда устанавливаться в последней версии.

Чтобы устанвить не последню версию, перехожу на страницу этого плагина и выбираю версию 3.9 и скачивается файл **git.hpi** В Advanced Settings 

![image-20231027165426570](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027165426570.png)

### Обновление Plagins

Jenkins сам выведет уведомление о том, что можно обновиться. Или же можно самому перейти в настройки - плагины и там в  updates будут доступные обновления.

### Удаление Plagins

Чтобы удалить, необходимо напротив нужного планина нажать **uninstall**

### Где все хранится на ВМ?

Чтобы увидеть все установленные плагины нужно перейти 

`$ cd /var/lib/jenkins/` 

И в этой директории будет папка `plugins/` в которой хранятся все плагины.

## 5. Простейшие Jobs

Должно получиться следующие

Два jobs которые абсолютно одинаковые, каждый будет собирать сайт, потом тестировать его и выгружать все на вервер. Просто сервера будут разные. Их я подниму на YandexCloud

![image-20231027171051113](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027171051113.png)

#### Как создавать простые Jenkins Jods

#### Job-1

Сделаю job который будет выполнять только 1 shell команду `echo "Hello WORLD"`

Для этого создаю job, а в buuild указываю что нужно выполнить shell команду и саму команду.

![image-20231027173737942](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027173737942.png)

Результат

![image-20231027173809088](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027173809088.png)

В выводе показано где выполняются все дейсвия (workspace)

Чтобы можно было выполнять job-ы одновременно, это нужно указать в настройках

![image-20231027173715922](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027173715922.png)

### Важные директории Jobs и Build на Jenkins Server

На ВМ хранится все тоже самое что есть в веб версии

Достаточно перейти в директорию `/var/lib/jenkins`

И в ней будет множество всего. К примеру если зати в директорию jobs, будут все существующие jobs по их именам, а внутри них будут builds и каждый запуск (если он не удален). В этом запуске можно посмотреть log файл в котором весь вывод консоли.

![image-20231027175359137](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027175359137.png)

### АвтоУдаление старых Build-ов

Как видно джобов может быть очень много и все их держать не нужно. По этому можно настроить автоудаление и оставлять например только последние 5

![image-20231027175649602](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027175649602.png)

В директории build файлы так же будут удаляться.

![image-20231027175748660](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231027175748660.png)

### Простейший пример доставки Artifact на удаленный сервер

Build and Test

Создаю html и сразу записываю ее в файл index.html - это build

Далее делаю тест путем поиска слова Hello в этом файле - это test 

![image-20231028133458879](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231028133458879.png)

![image-20231028134107216](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231028134107216.png)

Для третьего шага Deploy - необходимо установить плагин ssh через который Jenkins будет связываться в ВМ

![image-20231028134807611](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231028134807611.png)

Теперь в "Послесборочные операции" появилась возможность Send build artifacts over SSH

![image-20231028161301415](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231028161301415.png)

Чтобы была возможность подключаться по ssh, необходимо в настройках сервера Jenkins указать настройки Publish over SSH

Необходимо указать приватный ключ для сервера и публичный ключ для каждой ВМ подключаемоей по ssh к серверу Jenkins (приватный и публичный ключ не важно откуда брать, главное чтобы один открывал другой)

Так же нужно указать их локальное имя, ip, имя юзера и рабочую директорию 

Рабочу директорию можно указать и корень (/) тогда доступна будет вся ВМ, но нам нужна директория только `var/www/html`

Ниже есть кнопка проверки подключения - (Test Configuration).

![image-20231028140940433](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231028140940433.png)

Все сборка - тест - доставка реализованы

## 6. Добавление Slave | Node | Agent

Jenkins Slave/Nodes  нужен для того чтобы

- Снизить нагрузку с Jenkins Master
- Увеличить количество одновременных Build-ов
- Вuild разных платформ на разных серверах
  - Node1 - для .NET
  - Node2 - для JAVA
  - Node3 - для Ansible
  - Node4 - для Chef

Jankins slave может бежать где угодно, где может бежать JAVA, обычно это Linux, но можно и на Windows

Будет так ![image-20231028162228920](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231028162228920.png)

Самый популярный способ установления связи между master и slave/node - это ssh

Для этого нужно установить плагин:

- SSH Agent Plugin

Он даст возможность сохранить данные slave в credentials 

Настриваю nodes

### node1

Указываю корневую директорию - где будет работать jenkins (/home/slave1/jenkins) - то есть внутри эзера этой ВМ, в директории jenkins (ее я сам создал). В этой директории будте бежать все что запустит и отдаст на выполнение master

Labels - очень важная вещь - нужна для того чтобы master мог указать на каких slave/node будет бежать job. Их лучше указывать несколько, чередуются они через пробел (ubuntu ubuntu_ansible ubuntu_slave1) 

Чтобы подключаться по ssh необходимо далее выбрать эту функцию и создать ключ

ID придумываю сам, его так же просто копирую в описание

ssh ключ нужно указать приватный

Так же еще указываем что верим ключам по которым подключаемся

![image-20231028170201735](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231028170201735.png)

Итог

![image-20231028170420170](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231028170420170.png)

По аналогии зодаю node2

Итог

![image-20231028172630622](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231028172630622.png)

И теперь в настройках job можно указать label по которому будет назначен конкретный slave/node

![image-20231028173228960](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231028173228960.png)

И соотв логи

![image-20231028173301269](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231028173301269.png)

## Удаленное и локальное управление через Jenkins CLI Client

- Позволит управлять Jenkins из конмандной строки
- Позволит писать скрипты для Jenkins
- Управлять можно будеть Локально из командной строки самого Jenkins сервера
- Управлять можно Удаленно из командной строки вашего ПК

Команды будут запускаться при помощи файла `jenkins-cli.jar`, его можно скачать, если перейти в настройки -> CLI 

Пример, как пользоваться CLI на ВМ (master jenkins)

**Скачать файл CLI**: 

`$wget http://158.160.124.163:8080/jnlpJars/jenkins-cli.jar` - сслыка это на упомянутый выше файл, она там же в настройки -> CLI 

![image-20231029171318252](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029171318252.png)

**Авторизация**

`$java -jar jenkins-cli.jar -auth username:password -s http://localhost:8080 who-am-i`

Выдаст ошибку, потому что нужно указать корректного юзера и пароль, а еще лучше токен

![image-20231029171848387](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029171848387.png)

Создал юзера и задал ему пароль: password123

Теперь можно сделать авторизацию

![image-20231029172124545](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029172124545.png)

Желательно использовать token, это best практика.

Чтобы сделать token необходимо залокиниться под этим юзером (создавать для когото токены нельзя)

![image-20231029172427766](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029172427766.png)

Создал токен: token1: 110fdad6ae2eae693b719345548ea166d2

Теперь авторизацию можно сделать используя токен, а не пороль

![image-20231029172619845](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029172619845.png)

Чтобы не вписывать в командную строку секретные данные, типо логи и пароля или токена, можно сделать все через переменные environment variables. То есть через переменные нашей среды

`$export JENKINS_USER_ID=serviceuser`

`$export JENKINS_API_TOKEN=110fdad6ae2eae693b719345548ea166d2`

их можно проверить:

Если проверить файл env:

`$ env | grep JENKINS`

![image-20231029174833620](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029174833620.png)

Теперь можно не прописывать, но когда сеанс закончится эти credentials уничнтожатся.

![image-20231029175300494](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029175300494.png)

**Удаленный запуск** 

Для этого нужно тот же файл скачать на ПК и те же команды выполнить

`$wget http://158.160.124.163:8080/jnlpJars/jenkins-cli.jar` - установка файла

Задаю переменные

> `export JENKINS_USER_ID=serviceuser`
> `export JENKINS_API_TOKEN=110fdad6ae2eae693b719345548ea166d2`

Авторизуюсь

`$java -jar jenkins-cli.jar  -s http://localhost:8080 who-am-i`

### Делаю экспорт job из Jenkins

Все команды CLI можно посмотреть в самом Jenkins

![image-20231029180304857](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029180304857.png)

То есть сначала идет подключение к определенному юзеру, после какую команду выполнить

Чтобы узнать как зовут юзера нужна команда `who-am-i`, логина и пороля в этой команде нет, потому что их передали как переменные окружения

`$java -jar jenkins-cli.jar  -s http://localhost:8080 who-am-i`

Делаю экспорт Job-1 в формат .xml

`$java -jar jenkins-cli.jar  -s http://localhost:8080 get-gob Job-1 > myjob.xml `

![image-20231029180952094](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029180952094.png)

![image-20231029181200086](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029181200086.png)

Как видно файл скачался и теперь можно его изменить локально

Даже загрузить обратно

`$ java -jar jenkins-cli.jar  -s http://localhost:8080 create-job Job-1-from-CLI < myjob.xml`

Для этого нужно использовать команду `create-job` задать новое имя для джоба и изменить перенаправление, теперь из исправленного файла нужно данные отправить на сервер.

![image-20231029181436922](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029181436922.png)

![image-20231029182334721](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029182334721.png)

### ОСНОВНЫЕ КОМАНДЫ

![image-20231029182503655](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029182503655.png)

## 8. Деплоим из GitHub

Наглядно будут следующие действия 

![image-20231029184747874](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029184747874.png)

Сначала создам репозиторий

![image-20231029191210325](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029191210325.png)

Дальше я поднял ВМ, на которую скачал git, сделал ssh ключи чтобы можно было подключиться скачать и отправить в репозиторий файл. Клонировал репозиторий, создал файл и запушил все на github.

![image-20231029191357823](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029191357823.png)

Теперь необходимо сделать job. Чтобы он мог коммуницировать с github необходимо устновить для него плагин, это делалось ранее. Далее можно настраивать.

![image-20231029194915700](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029194915700.png)

Важно указать правильную ветку

![image-20231029194958919](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029194958919.png)

Как видно jenkins смог подключиться к github и взять от туда файл index.html, даже изменил последнюю строчку.

## Автоматизация запуска Build Job из GitHub - Jenkins Build Triggers

Ранее Jobs запускались механически, нажимая кнопку запуска

Но есть 4 основных типа автоматических запуска^

**Build Rtiggers**

- **Trigger builds remotely (e.g. from scripts)**

  Будет возможность запускать через URL (он выдастся), любой кто откроет его этот url запустит автоматически Job

- **Build after other projects are built**

  Job будет старотовать после того как закончится какой то другой Job

- **Build periodically**

  Выполнение по расписанию

- **Poll SCM**

  Тоже запуск по расписанию, но с отличием в том, что будет всегда проверять репозиторий и если есть изменения то будет стартовать Job. Этот тип работает вместе с GitHub. И по по факту расписание настраивается для проверок. Проверка - это сравнение последнего коммита, если он не такой как в прошлый то нужно запусить Job

- **Triggers from Installed Plugins**

  и любой другой, если скачать плагин 

  

**Trigger builds remotely (e.g. from scripts)**

Чтобы создать URL для запуска нужно придумать токен.

После чего необходимо собрать URL, как в описании

```yaml
JENKINS_URL/job/Build-AutoTrigger-1/build?token=TOKEN_NAME
---> заменяю JENKINS_URL ---> на http://158.160.124.163:8080/ --->
http://158.160.124.163:8080/job/Build-AutoTrigger-1/build?token=TOKEN_NAME
---> вставляю придуманный токен --->
http://158.160.124.163:8080/job/Build-AutoTrigger-1/build?token=sfadafdasd888asdfsdf89asdfasdfsd9

+++++++++ итоговая ссылка ++++++++
http://158.160.124.163:8080/job/Build-AutoTrigger-1/build?token=sfadafdasd888asdfsdf89asdfasdfsd9
```

![image-20231029205620984](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029205620984.png)

После ввода будет пустая страница

![image-20231029205912272](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029205912272.png)

И сразу запустится Job

![image-20231029205934167](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029205934167.png)

Чтобы запустить таким образом Job из консоли (в скрипте например) необходимо автаризоваться как пользователь, для этого нужен пороль или токен. Через токен безопаснее.

Берем токен и немного изменяем URL (добавляю авторизацию)

```yaml
http://158.160.124.163:8080/job/Build-AutoTrigger-1/build?token=sfadafdasd888asdfsdf89asdfasdfsd9
---> юзер: vladimirsemchishin токен: 1151575c80d1f06ec0552ea9c863d478f3 --->
http://vladimirsemchishin:1151575c80d1f06ec0552ea9c863d478f3@158.160.124.163:8080/job/Build-AutoTrigger-1/build\?token\=sfadafdasd888asdfsdf89asdfasdfsd9
```

Таким образом, чтобы выполнить переход необходима утилита curl:

`$ curl http://vladimirsemchishin:1151575c80d1f06ec0552ea9c863d478f3@158.160.124.163:8080/job/Build-AutoTrigger-1/build\?token\=sfadafdasd888asdfsdf89asdfasdfsd9`

**Build after other projects are built**

Запуск после выполнения другого Job. Укажем в качестве первого тот, который запускается через url.

![image-20231029211604045](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029211604045.png)

Как видно, все работает

![image-20231029211752004](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029211752004.png)

Это может быть полезно, если первый job поднимает инфраструктуру при помощи Terraform, а последующий уже что то разворачивает на этих серверах.

**Build periodically**

Тут есть крутое объяснение. Синтаксис выставления времени такое же как в  `cron`

Сделаем запуск каждые 2 минуты. (H это просьба jenkins, если ее указать, а не *. То одновременных запусков джобов не будет, а будет все равномерно)

![image-20231029212410339](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029212410339.png)

**Poll SCM**

Здесь будет проверяться переодически репозиторий, если есть изменени выполнится job.

По этому есть взаимосвязь управления исходным кодом и триггера. Если не указать git правильное к нему подключение ничего работать не будет.

![image-20231029213600121](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029213600121.png)

## 10. Автоматизация запуска Build из GitHub - Jenkins trigger from GitHub, Jenkins <u>webhook</u>

Для того чтобы была возможность не проверять постоянно репозиторий GitHub на наличие изменений и не перегружать сервер c Jenkins. Удобно воспользоваться плагином GitHub при помощи которого появляется возможность пользоваться webhook.

Суть заключается в том, что необходимо настроить `webhook` в репозитории на github

Первая часть ссылки - это адресс сервера, а вторая это что то типо указателя, который говорит что это запрос webhook. 

Jenkins получив данный запрос идет на этот репозиторий, потому что в настройках джобы указан репозиторий к которому он может подключиться. И если у него это получается сделать по заданному в настройках ssh и в репозитории и правда есть еще не примененные изменения. Джоба выполняется.

![image-20231029221645974](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029221645974.png)

![image-20231029222543245](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029222543245.png)

## 11. Build с Параметрами

О том как запускать job с параметрами, то есть как добавлять переменные с дефолтными значениями. Чтобы из можно было сразу использовать в работе джобы.

Их достаточное количество:

- String Parameter 
- Choice Parameter 
- File Parameter

Для этого нужно указать что сборка будет с параметрами и определить какой тип будет у параметра. После чего задать его. 

**String Parameter** - строковый параметр

![image-20231029225151199](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029225151199.png)

Далее в сборке его можно будет использовать.

![image-20231029225235138](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029225235138.png)

Дальше при запуске Jenkins будет ожидать что вы можете исправить значение переменой

![image-20231029225429200](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029225429200.png)

**Choice Parameter** - параметр, нужно создать варианты для выбора.

![image-20231029225958192](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029225958192.png)

![image-20231029230118612](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20231029230118612.png)

**File Parameter** - позволяет загрузить файл

Сначала нужно написать маршрут: UPLOADFILE - я указал просто название файла. Оно кстати всегда будет переименовываться в то которое указано.

**Password Paramenter** - позовляет указать логин и пароль. Но если вызвать это переменную просмотреть, она не будет зашифрованной.



