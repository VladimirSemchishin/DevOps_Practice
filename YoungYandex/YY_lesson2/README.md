Это описание работы над выполнением второго домашнего задания Yandex тренировок.

# DevOps-тренировки в Яндексе

# 02.11.23. Облако. Кто виноват и что делать? 

Домашнее задание для DevOps-тренировок в Яндексе, лекция "Облако. Кто виноват и что делать."

https://yandex.ru/yaintern/training/devops-training

Ссылка на репозиторий с заданием

https://github.com/krya-kryak/y-y-devops-trainings-cloud-1

# Шаги по реализации

Есть файловая структура.

![image-20231113210733694](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231113210733694.png)

Где из важных директорий:

- `y-y-devops-trainings-cloud-1` - репозиторий
- `catgpt` - директория приложения, автоматически улучшающее фотографии путём дорисовывания фотореалистичных котиков, написанное на Golang
- `terraform` - директория в которой лежат terraform-инструкции для разворачивания MVP

## Что я сделаю:

1. Terrafrom1
   - Разберусь как работают уже написанные файлы terraform
   - Напишу свой манифест (должно получиться тоже самое)
2.  Docker
   - Напишу DockerFile 
3. Yandex Container Registry
   - Публикация Docker image в Yandex Container Registry
4. GitHub CI
   - Сделать автосборку
5. Terraform2
   - Развернуть стенд с приложением
6. Monitoring
   - Построить графики в Yandex Monitoring на которых можно будет посмотреть разбивку:
     - по типам нарисованных котивов (дневных и ночных)
     - по кодам ответов, хендлерам и методам
   - Дополнительно инструментировать приложение и доработать дашборд для того, чтобы получить графики времён обработки запросов в разрезе handler и method
7. Проверка
   - Выключить одну из виртуальных машин. Убедиться, что сервис продолжает жить и обслуживать запросы

## 0. Yandex Cloud

Создаю сервисный аккаунт, при помощи которого будут выполняться все инструкции terrafrom файла.

![image-20231113223342344](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231113223342344.png)

Про роли:

https://cloud.yandex.ru/docs/iam/concepts/access-control/roles

Начало работы с Terrafrom в Yandex Cloud: https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart

Я ранее пользовался Yandex Cloud, по этому мне нужно настроить CLI для выполнения операций от имени сервисного аккаунта

![image-20231113230403865](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231113230403865.png)

Создался авторизованный ключ и записался в файл:

![image-20231113230551680](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231113230551680.png)

Создал профиль CLI для выполнения операций от имени сервисного аккаунта

![image-20231113231458300](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231113231458300.png)

Задаю конфигурацию профиля и добавляю аутентификационные данные в переменные окружения 

![image-20231113231550630](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231113231550630.png)

Далее в файле конфигурации `~/.terraformrc` перепроверяю правильность настроек, чтобы было в соответствии с докой (настройка зеркала).

Следующий шаг - объявление провайдера.

Нужно создать файл с расширением .tf Например: main.tf 

![image-20231115071038078](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231115071038078.png)

И инициализировать Terraform в директории с main.tf

```yaml
  terraform init
```

![image-20231115071347937](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231115071347937.png)

Тут говориться что революционизировались плагины провайдера и создалась директория  .terraform.loc.hcl - это файл записи выбора провайдера, он должен находится в репозитории, чтобы настройки были соблюдены при следующих выполнениях `terraform init` Так же есть предупреждение о том, что из-за индивидеального метода установки провайдера, вынуждено локально были рассчитаны контрольные суммы файлов блокировки. По этой причине файны конфигурации корректно запустятся только на linux_amd64.

Подробную информацию о ресурсах, создающихся с помощью Terraform, см. в [документации провайдера](https://terraform-provider.yandexcloud.net//).

https://terraform-provider.yandexcloud.net//

## 1. Terraform1

![image-20231115091446308](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231115091446308.png)

Для того чтобы узнать о функциях, можно обратиться к документации

https://developer.hashicorp.com/terraform/language/functions/

В общем виде готовый и исполняемый файл выглядит так:

![image-20231115214838376](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231115214838376.png)

![image-20231115215002375](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231115215002375.png)

Файловая система на данный момент:

![image-20231115215102069](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231115215102069.png)

## 2. Docker

Теперь нужен образ контейнера, который будет отправлен в registry и в последствии развернут на ВМ.

Суть заключается в том, чтобы собрать multi-stage сборку, где первым слоем использовать базовый образ с дистрибутивом (golang:1.21), собрать приложение и вторым слоем использовать образ без дистрибутива, в котором будет только то что необходимо для выполнения уже скомпилированного файла (cr.io/distroless/static-debian12:latest-amd64).

Подробнее про [multi-stage builds](https://docs.docker.com/engine/userguide/eng-image/multistage-build/):

https://docs.docker.com/build/building/multi-stage/

Страничка Docker image golang - там есть минимальное объяснение что нужно сделать для запуска приложения написанное на Golang

https://doka.guide/tools/dockerfile/

![image-20231124122009483](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231124122009483.png)

## 3. Yandex Container Registry

Инструкция: https://cloud.yandex.ru/docs/container-registry/quickstart/

![image-20231124123049308](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231124123049308.png)

Дальше нужно авторизоваться. Docker Engine может хранить учетные данные пользователя во внешнем хранилище. Это безопаснее, чем хранить их в конфигурационном файле Docker. Чтобы использовать хранилище учетных данных, необходима внешняя программа — [Docker Credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers).

*В состав Yandex Cloud CLI входит утилита `docker-credential-yc`, которая выступает в роли Docker Credential helper для Yandex Cloud. Она хранит учетные данные пользователя и позволяет работать с приватными реестрами Yandex Cloud, не выполняя команду `docker login`. Этот способ аутентификации поддерживает использование от имени пользователя и от имени сервисного аккаунта.*

Конфигурирую Docker для испольлзования docker-credentail-yc

![image-20231124123829464](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231124123829464.png)

Проверка, должна появиться выделенная строка. Если да, то docker готов к выгрузке образов в Container Registry 

![image-20231124124012400](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231124124012400.png)

Подготовка к выгрузке

Есть образ контейнера:

![image-20231124125423424](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231124125423424.png)

Переименую согласно документации

```shell
$ docker tag go-project-catgpt:v1 cr.yandex/crp0nup5l5mvv4pdf2e7/go-project-catgpt:v1
```

![image-20231124134045607](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231124134045607.png)

Отправка в Container Registry

![image-20231124134550799](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231124134550799.png)

![image-20231124134649153](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231124134649153.png)

Удалю все образы когда либо созданные и скаченные, чтобы было понимание, что образ берется именно из Container Registry

![image-20231124142311160](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231124142311160.png)

![image-20231124140424120](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231124140424120.png)

Все работает

## 4. GitHub CI 



------

### GitHub Actions

Для начала нужно разобраться что такое GitHub Actions и его компоненты.

GitHub Actions — это платформа непрерывной интеграции и непрерывной доставки (CI/CD), которая позволяет автоматизировать конвейер сборки, тестирования и развертывания. Вы можете создавать рабочие процессы, которые создают и тестируют каждый запрос на включение в ваш репозиторий, или развертывают объединенные запросы на включение в рабочую среду. 

GitHub Actions выходит за рамки простого DevOps и позволяет запускать рабочие процессы, когда в вашем репозитории происходят другие события. Например, вы можете запустить рабочий процесс для автоматического добавления соответствующих меток всякий раз, когда кто-то создает новую задачу в вашем репозитории. 

GitHub предоставляет виртуальные машины Linux, Windows и macOS для запуска ваших рабочих процессов, или вы можете разместить свои собственные автономные бегуны в собственном центре обработки данных или облачной инфраструктуре.

Компоненты

Вы можете настроить рабочий процесс (**workflow**) GitHub Actions, который будет запускаться при возникновении события в вашем репозитории, например при открытии запроса на включение или создании измнения. Ваш рабочий процесс содержит одно или несколько заданий (**jobs**), которые могут выполняться последовательно или параллельно. Каждое задание будет выполняться внутри своей собственной виртуальной машины (**runner**) или внутри контейнера и имеет один или несколько шагов (**steps**), которые либо запускают определенный вами сценарий, либо запускают действие (**actions**), которое представляет собой повторно используемое расширение, которое может упростить ваш рабочий процесс.

![image-20231124154412857](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231124154412857.png)

- **Workfows**

  Рабочий процесс. Настраиваемый автоматизированный процесс, который запускает одно или несколько заданий (**jobs**). Рабочие процессы определяются в файлах формата YAML, находятся в `.github/workflows`.  Подробнее про повторное использование  "[Reusing workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows)." и про само их использование.

- **Events** 

  Событие. Это опр действие в репозитории, которое запускает **workflow**. Например когда кто-то создает pull request. Полный список событий: [Events that trigger workflows](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows).

- **Jobs**

  Задание. Это набор шагов выполняемых одним исполнителем (**runner**), jobs может быть много и они могут зависеть друг от друга, брать информацию из прошлого (тк исполняет их один раннер) (например build -> test -> deploy). Так же можно просто запускать одну джобу после другой.  "[Using jobs](https://docs.github.com/en/actions/using-jobs)."

- **Actions**

  Действия. Это специальное приложение для GitHub Actions, с помощью которого можно выполнять сложные но часто повторяющие задачи, например получить репозиторий git из github, настроить сборку или аутентификацию для облачного провайдера. "[Creating actions](https://docs.github.com/en/actions/creating-actions)."

- **Runners**

  Бегун. Это сервер, которые запускает workfows когда есть соотв. триггер. Отдельные runners могут исполняться параллельно. Они запускаются на отдельных ВМ их предоставляет GitHub но можно поставить и на своей "[Hosting your own runners](https://docs.github.com/en/actions/hosting-your-own-runners)."

**Пример**:

![image-20231125135839552](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231125135839552.png)

Визуализация

![image-20231125135946184](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20231125135946184.png)



**Полезные ссылки:**

- "[Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#run-name)."
- "[Using starter workflows](https://docs.github.com/en/actions/learn-github-actions/using-starter-workflows)."
- CI "[Automating builds and tests](https://docs.github.com/en/actions/automating-builds-and-tests)."
- "[Publishing packages](https://docs.github.com/en/actions/publishing-packages)."
-  "[Deployment](https://docs.github.com/en/actions/deployment)."
- "[Managing issues and pull requests](https://docs.github.com/en/actions/managing-issues-and-pull-requests)."
- For examples that demonstrate more complex features of GitHub Actions, including many of the above use cases, see "[Examples](https://docs.github.com/en/actions/examples).



------

## Пояснительная бригада 

### Развернуть стенд с приложением в Terraform.

Разворачивание стенда с приложением в Terraform <u>подразумевает автоматическую настройку и развертывание всех необходимых ресурсов для работы приложения</u>.

Развернуть стенд включает в себя:

1. Создание инфраструктуры: развертывание серверов, сетей, баз данных и других необходимых компонентов.
2. Установка и настройка приложения: загрузка исходного кода, его компиляция и развертывание на сервере, а также конфигурация и настройка всех зависимостей и сервисов.

**Terraform** - это инструмент для управления конфигурацией IT-инфраструктуры, который позволяет автоматизировать такие задачи, как создание и настройка серверов, баз данных, сетей и других ресурсов. 

Три ключевых преимущества Terrafrom:

1. Управление ресурсами: Terraform позволяет отслеживать изменения в конфигурации и автоматически обновлять или удалять ресурсы при необходимости.
2. Возможность повторного использования кода: Terraform поддерживает использование шаблонов (т.н. “провайдеры”) для быстрого и легкого создания и развертывания инфраструктуры, что упрощает процесс разработки и развертывания приложения.
3. Управление версиями: Terraform хранит историю изменений конфигурации, что позволяет легко вернуться к предыдущей версии или откатить изменения.
   

### За что отвечают файлы go.mod go.sum в приложении написанном на golang?   

Файлы go.mod и go.sum используются в приложениях, написанных на языке программирования Go, и служат для разных целей:

Файл go.mod (модуль) - это файл, который описывает зависимости модуля вашего приложения. Он содержит информацию о других модулях, их версиях и сторонах, которые необходимо скачать и установить для успешной компиляции программы. Файл go.mod позволяет системе сборки Go автоматически управлять зависимостями и разрешать коллизии между разными версиями.
Файл go.sum - это сумма sha256 для каждого модуля, используемого в проекте. Он помогает обнаруживать изменения в модулях и используется для проверки целостности зависимостей перед компиляцией. Если какой-либо из модулей был изменен, сумма sha256 будет отличаться от указанной в файле go.sum, и система сборки Go не будет использовать такой модуль. Это обеспечивает защиту от возможных уязвимостей и проблем с совместимостью версий.
