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

`cat file.txt`  - выведет в консоль содержание файла

`more file.txt` - выведет содержание файла (пролистывание по строчкам)

`less file.txt` - открыть файл

`touch` - обновить файл (может создать не существующую, если touch file.txt который уже существую, он просто измениь время его modified) 

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

## Архивирование и Сжатие tar, gzip, bzip2, xz, zip

`tar cf mytar.tar Folder1` команда для архивирования, объединяет несколько файлов в один файл. (c - create; f - file ) f всегда должен быть последним, mytar.tar название файла архива, Folder1 - что будет лежать в архиве. Можно добавить -v чтоюы видеть что изменилось

![image-20230913104247050](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230913104247050.png)

 `tar tf mytar.tar` - просмотр архива (t - test)

`tar xf mytar.tar -v` - разархивировать (x - extract)

### Компресирование (делает меньше файлы .tar)

`gzip mytar2.tar` - сжимает и добавляет расширение (.gz)

`gunzip mytar2.tar` разжать (разкомпресировать)

`bzip2 mytar2.tar` - тоже самое только по лучше сжимает (расширение .bz2) (лучше всех сжимает)

`bunzip2 mytar2.tar` - разжимает 

`xz mytar2.tar` - сжать 

`unxz mytar2.tar` - разжать

Можно сделать все в одном, поскольку команда `tar` предусматривает использование компрессии

`tar czf myGZIP.gz Folder1` - создание сразу сжатого архива .gz (нужно z)

`tar cjf myBZIP.bz Folder1` - создание сразу сжатого архива .bz (нужно j)

![image-20230913110044217](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230913110044217.png)

Распаковка сжатых файлов такая же как и просто архив.

### Так же можно использовать ZIP

`zip -r myZIP.zip Folder1` - r необхдим чтобы взялись и внутренние файлы (рекурсивно) (самый тяжелый кратно)

 `unzip myZIP.zip`  - распокавать.

## Процессы и Память: top, free, ps

`top` - менеджер задач (task) в линукс (shift+p - отсортировать по cpu shift+m - отсортировать по памяти)

![image-20230914070521771](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914070521771.png)

`free -h` - посмотреть память -h (humon) в человеческом виде

![image-20230914072005708](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914072005708.png)

`ps` - посмотреть запущенные процессы (у него 3 флага -u указать юзера, -a все(all), -x детальнее и вместе с процессами команд запущенных в этой сессии)

![image-20230914072040756](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914072040756.png)

Все лог файлы хранятся в директории `/var/log`

Лог линукс ядра, он сущетвует только когда ВМ работает: `/var/log/dmesg`  (он в памяти, на диск не сохраняется)

## Типы аккаунтов и важные файлы

Типы аккаунтов:

- Standart
- Administrator - может использовать команды c sudo (тк он в группе sudo)
- Root - создается по умолчанию 

`/home` - создаются папки пользователя

`/etc/passwd` - файл в котором прописаны все пользователи (в том числе системные)

![image-20230914074537768](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914074537768.png)![image-20230914074553238](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914074553238.png)

`/etc/shadow` - тут лежат пароли

![image-20230914074938168](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914074938168.png)

![image-20230914074950087](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914074950087.png)

`/etc/group` - список групп и кто в них находится

![image-20230914075205455](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914075205455.png)

`whoami` - узнать имя текуще пользователя

![image-20230914075312421](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914075312421.png)

id - узнать id изера грппы и тех группы к которым юзер принадлежит

![image-20230914075448661](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914075448661.png)

`last` - выдаст кто делал и когда log in  

![image-20230914075618495](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914075618495.png)

`who` - какой юзер сейчас активен

![image-20230914075804901](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914075804901.png)

`w` - тоже самое что who только больше информации (чем занят юзер)

![image-20230914075915993](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914075915993.png)

## Пользователи и Группы

Пользователей может сосздавать юзер который входит в группу sudo (чтобы исп. права супер пользователя root)

`sudo useradd -m  user1` - создание пользователя (m создать home directory) 

![image-20230914081925993](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914081925993.png)

![image-20230914081939096](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914081939096.png)

Но у этогго пользователя нет пароля,об этом говорит файл etc/shadow, в него нельзя залогиниться

![image-20230914082129514](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914082129514.png)

`sudo passwd user1` - задать пароль юзеру

![image-20230914082235883](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914082235883.png)

И в  etc/shadow появился пароль

![image-20230914082315618](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914082315618.png)

Когда создается пользователь, на основе создающего юзера создается скелет (копируется)

`etc/skel` - директория которая копируется новым пользователям

`sudo userdel user1` - чтобы удалить только директорию user1, чтобы удалить все что связано, нужно удалить внутренние файлы и директории этого юзера, исп -r 

![image-20230914083732714](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914083732714.png)

`sudo groupadd Programmers` - создание группы (проверить в файле ../../etc/group)

![image-20230914084019578](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914084019578.png)

`sudo groupdel Programmers` - удалить группу

`sudo usermod -aG Programmers user2` - добавить изера в группу (a - append) 

![image-20230914084543448](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914084543448.png)

![image-20230914084527469](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914084527469.png)

![image-20230914084458905](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914084458905.png)

Можно добавлять в группу и через цифру

![image-20230914084824620](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914084824620.png)

`sudo deluser user2 sudo` - убрать из группы

![image-20230914085120068](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914085120068.png)

## Права Доступа и владения файлами и директориями

![image-20230914090254471](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914090254471.png)

Первый параметр - это указание прав на объект ( - --- --- --- )

`-` - может быть файлом (-), директорией (d) или линком (l)

Остальные пунктиры - это права для user group other (r (read), w (write), x (execute - выполнять))

`smvn smvn` - указание владельца и группы

`sudo chown user2 link_text1` - поменять владельца (change owner) (его права rw-)

![image-20230914090412256](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914090412256.png)

изменился файл, на который ссылается link (т.е. text1)

`sudo chgrp Pogrammers text1` - изменить группу (их права rw-)

![image-20230914090948602](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914090948602.png)

`sudo chmod o+x taxt1` - изменить права буквами (o - others x - execute)

![image-20230914091410617](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914091410617.png)

`sudo chmod u-w,g-w text1` - пример как убрать у нескольких

Можно изменять права цифрами

![image-20230914091636782](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914091636782.png)

`sudo chmod 777 text1` - (первая цифра это user)

![image-20230914092439065](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914092439065.png)

### sticky bit

В директории в которой все могут делать все, есть файлы, к которым закрыт доступ текущему пользователю он не может даже прочесть ничего

![image-20230914092843346](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914092843346.png)

Но поскольку директория разрешает делать все всем (ее права 777), любой может удалить файл который даже просмотреть не может

![image-20230914093003271](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914093003271.png)

Чтобы такого небыло, а управлять файлами мог только тот у кого есть права, директории для остальных можно дать право sticky bit (`o+t`) или через цифру (`0777` - 0 это убрать  `1777` - 1 это добавить)

`sudo chmod o+t Folder1` - дать наследование прав от файлов

![image-20230914093314222](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914093314222.png)

## Сетевые комманды

утилита ip

`ip addr` - узнать ip адресс вм

![image-20230914102713725](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914102713725.png)

Показывает что есть 3 сетевых устройства и информацию о них

`ip route` - запись в таблице маршрутизации (можно добавить в конце show)

![image-20230914134555512](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914134555512.png)

`ping -c 4 8.8.8.8` - команда пинг (адресс указа гугла www.google.com) флаг -c указвает сколько раз нужно обратиться на этот адрес (4 раза)

![image-20230914135048037](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914135048037.png)

`host` - вернет ip имени хоста

![image-20230914135340334](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914135340334.png)

`dig www.microsoft.com` - domain information groper, выведет информацию о домене

![image-20230914140348856](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914140348856.png)

`netstat` - показывает статистику приема и отправки пакетов, а также информацию об ошибках приема и отправки

![image-20230914141052018](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914141052018.png)

## Скачивание и Установка программ

`wget src` - (web get) скачивать из интернета (ссылка должна быть прямо до файла, скачивать можно по 1)

### Для Debian

`sudo apt-get install chromium-bsu` - скачивает и устанавливает пакет из репозитория

`whereis chromium-bsu` - чтобы узнать куда установился пакет 

![image-20230914144331864](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914144331864.png)

`sudo apt-get remove chromium-bsu` - удалить пакет

![image-20230914144627731](/home/smvn/snap/typora/86/.config/Typora/typora-user-images/image-20230914144627731.png)

Линукс знает где искать данный пакет по имени, потому что у него прописаны repository в файле 

`cat ../../etc/apt/sources.list` - в это файле места где ищутся пакеты

Чтобы скачать локально пакет (для лиинукса типа убунту расширение .deb) нужно его скачать и становить

`wget src ` - скачать файл

`sudo dpkg -i  xdemineur_2.1.1-18_amd64.deb` - флаг i это install

`whereis xdemineur` - чтобы узнать куда он установился

`sudo dpkg -r xdemineur` - удалить пакет (название нужно писать основное, то есть если скачался пакет xdemineur_2.1.1-18_amd64.deb, то нужно указать основное имя xdemineur)

### Для RedHat

Скачивать так же: `wget src`

Установить: `sudo yum install chromium-bsu`

Удалить: `sudo yum remove chromium-bsu`

Расширение для RedHat `.rpm`

Установка пакета: `rpm -i <имя скаченного_файла.rpm>`

Удаление:  `rpm -e <короткое имя>`

### Полезное 

Перезапуск пк : `sudo reboot now`

Выключение пк `sudo shutdown now`

