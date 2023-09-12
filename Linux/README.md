# LINUX

## Работа с терминалом man, ps, uptime

`uptime` - узать время 

`uname` - инструмент, который чаще всего используется для определения архитектуры процессора, имени хоста системы и версии ядра, работающего в системе.

![image-20230912072629214](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912072629214.png)

`uname -a` тоже самое, только с флагом `all`

`lscpu` - выведет информацию о архитектуре процессора

![image-20230912072841732](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912072841732.png)

Команды ищутся в `$PATH`, чтобы посмотреть в каких директориях лежат уже забитые переменные: `$echo $PATH` 

![image-20230912072354447](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912072354447.png)

`clear`  - очистит консоль от записей

`echo` выведет в консоль текст

`ctrl + alt + f3` - открыть консольную версию линукс (f7 вернуться в графическую версию)

`man -k clear` - (k это keyword) man - читать мануал по какой то команде кратко. 

![image-20230912074613080](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912074613080.png)

`man clear` читать полный мануал по команде. чтобы искать нужно в открытом файле через консоль /'то что нужно найти'

`whatis uptime` - то же что и man -k

![image-20230912074835744](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912074835744.png)

`whereis` uptime - найти расположение команды

![image-20230912074906134](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912074906134.png)

`locate uptime` - найти файл с таким именем 

`ping ww.google.com` - проверить доступ этого сайта

![image-20230912075148343](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912075148343.png)

`ctrl + c` - убить и выйти из процесса

`ctrl + z` - не убивать процесс, но выйти 

`ps` - посмотреть какие процессы бегут в сеансе на момент вып. команды (тк исп ctrl + z для скрытия ping он выведен как бегущий процесс)

![image-20230912075243370](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912075243370.png)

`fg` - вернуться на бегущий процесс ( вернул отображение запущенного ping)

![image-20230912075348038](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912075348038.png)

## Навигация по Файлам и Директориям

В линуксе есть только `/`  - это самая корневая директория ($cd / $ls -la)

![image-20230912081728313](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912081728313.png)

`ls -la` - (l - longa, a -all ) - покажет подробную информацию о файлах и папках текщей директории  (в том числе скрытых)

`pwd` - print working directory 

![image-20230912082526136](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912082526136.png)

`cd` - перейти (`..` - вернуться на 1 директорию, `../..` - вернуться на 2 директории, `/` - в корень, без всего или `~` - домашняя директория пользователя)

## Работа с файлами - создание, копирование, перенос, переименование, стерание файлов

### Просмотр файлов

cat file.txt  - выведет в консоль содержание файла

more file.txt - выведет содержание файла (пролистывание по строчкам)

less file.txt - открыть файл

touch - обновить файл (может создать не существующую, если touch file.txt который уже существую, он просто измениь время его modified) 

### Копирование

`cp src dest -v`- копировать (что куда) флаг -v покажет куда они копируются

![image-20230912090037082](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912090037082.png)

`?`  -  это один любой знак, `*` - это любое количество любых знаков

Чтобы скопировать директорию в директорию нужен флаг -r (--recursive)

`cp dir2 NewDir -v -r`

![image-20230912090637388](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912090637388.png)

### Переименование

`mv file .file -v` - переименовать (. перед названием делает файл невидимым) 

![image-20230912090909482](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912090909482.png)

## Работа с директориями

`mkdir namedirectory` - создание, не создает полный путь только конечную

`mkdir -p dir3/dir4/dir5` - создает путь и конечную директорию

![image-20230912091254659](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912091254659.png)

### Переименование 

`mv dir1 dir2`

### Стереть

`rmdir dir1` - стирает только пустые директории

`rm -r dir1` - стирает не только пустые директории

### ОПАСНАЯ КОМАНДА

`sudo rm -r /` - стереть все файлы (умрет пк)

## Создание Линков 

### это создание ссылок на файлы или директории

###### , то есть из любой точки файловой системы можно по линку перейти к указанному файлу

`ln -s src NameLink` - нужно указать путь до файла или папки и имя которое будет у линка (то есть папки которая при переходе на нее перенесет вас по указанному пути) -s (sympolic)

![image-20230912093709877](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912093709877.png)

### Дубликат линоков (только для файлов)

`ln linux-history.txt linux-history_dublicate.txt` - создание полного дубликата, теперь если изменить один из файлов, изменения появятся и на другом 

видно что вывод записался в дубликат, но и в оригинале он есть

![image-20230912094615500](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912094615500.png)

##  Команды find, cut, sort, wc

`find src -name "что искать"` - поиск, сначала нужно указать где искать, потом через флаг -name "что искать" 

![image-20230912095046396](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912095046396.png)

`wc file.txt` - распечатать сколько в файле строк, слов и байт (-l только строк, -w только слов)

![image-20230912095558369](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912095558369.png)

`sort file.txt` - сортирует файл (-n сортировать по номерам)

![image-20230912100051092](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912100051092.png)

`cut -d "<" -f 2 linux-history_dublicate.txt` - если в файле есть разделение по какому то элементу, то можно вывести только часть файла -d (--delimiter=DELIM) -f (--fields=LIST) и указать в каком файле

![image-20230912100837365](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912100837365.png)

`|` - это pipe, после него можно записать команду для выполнения (получится конвеер)

![image-20230912101039463](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912101039463.png)

## Команда grep и Регулярные Выражения

`grep Linux ./*` - поиск по файлам, что искать (Linux) где искать (./* текущая директория все)

![image-20230912101657113](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912101657113.png)

`grep linux ./* -i` - доп флаг это игнорировать заглавные буквы  

![image-20230912102110794](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912102110794.png)

### Регулярные выражения 

Нужно построить патерн, строится он следующим образом, есть файл в котором например нужна почта

`grep .gov mydatfile.txt` - указываем что ищем строку оканчивающую на .gov

`grep [A-Za-z]*.gov mydatfile.txt` - указываем что перед точкой могут быть буквы от A до Z большие и маленькие, любые и скок угодно.

`grep -E"[A-Za-z].gov" mydatfile.txt` - E, --extended-regexp Интерпретировать ШАБЛОНЫ как расширенные регулярные выражения 

`grep -E"@[A-Za-z].gov" mydatfile.txt` - указываем что эти буквы после @ но до .gov

`grep -E"[A-Za-z\.]*@[A-Za-z].gov" mydatfile.txt` - указываем что перед @ могут быть любые буквы в том числе точки (точка обозначается так \.)

![image-20230912103039131](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912103039131.png)

![image-20230912103820429](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912103820429.png)

Если нужна почта не только .gov: `grep -E"[A-Za-z\.]*@[A-Za-z].(gov|mail)" mydatfile.txt`

## Перенаправление вывода / ввода - /dev/null

Перенаправить вывод и перезаписать

`sort linux-history.txt > sort_linux-history.txt` - если файла не было он создастся и в него запишется вывод, если файл уже существовал, то то что внутри перезапишется.

![image-20230912104221933](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912104221933.png)

`sort -n nymeric >> sort_linux-history.txt` -  добавление в конец файла

![image-20230912104740499](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912104740499.png)

Если сделать такую команду: `sort -n nymeric > nymeric` файл не станет сортированным, потому что тот файл в который будет записан вывод, сначала создается (пустым, тк в нем будет только вывод команды), а потом записывается команда, но т.к команда сортировки будет обращаться к пересозданному новому файлу, сортировать уже будет нечего.

Когда линукс выдает ответ, он выдает их в 2 потоках, хорошие и плохие. Их можно перенаправлять

`grep smvn /etc/* 2> errors.txt` - перенаправит ошибки в файл с ошибками, а хорошие ответы выдаст в консоль

![image-20230912110149526](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230912110149526.png)

`grep smvn /etc/* > good.txt 2> /dev/null` - перенаправление  хороших ответов в файл good, а ошибок в error

`grep smvn /etc/* &> results.txt` - перенаправит и хороший вывод и плохой в один файл. 

(Тк просто `>` это только хороший поток, а `2>` только плохой)







