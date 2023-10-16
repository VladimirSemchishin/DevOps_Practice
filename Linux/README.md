# LINUX

## Работа с терминалом man, ps, uptime

### Инофрмация о ВМ

`uptime` - узать время 

`uname` - инструмент, который чаще всего используется для определения архитектуры процессора, имени хоста системы и версии ядра, работающего в системе.

![image-20230912072629214](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912072629214.png)

`uname -a` тоже самое, только с флагом `all`

`lscpu` - выведет информацию о архитектуре процессора

![image-20230912072841732](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912072841732.png)

### Переменные в ОС

`echo $PATCH` - переменная позволяющая сократить длину вып. команд в терминале или скрипте (не нужно каждый раз прописывать полный путь к требуемым файлам)

Команды ищутся в `$PATH`, чтобы посмотреть в каких директориях лежат уже забитые переменные: `$echo $PATH` 

![image-20230912072354447](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912072354447.png)

Чтобы добавить новый путь нужно использовать `export` 

![image-20230919074046432](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230919074046432.png)

Это будет работать до первой перезагрузки, чтобы полностью сохранить изменения, можно:

-  изменить значение переменной `PATH` в файле `/etc/environment` (для убунту)
- изменить скрипт запуска оболочки bash (`$vi ~/.bashrc`) - прописать в конце export `PATH=$PATH:/opt/local/bin`

![image-20230919074910965](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230919074910965.png)



`clear`  - очистит консоль от записей

`echo` выведет в консоль текст

`ctrl + alt + f3` - открыть консольную версию линукс (f7 вернуться в графическую версию)

`man -k clear` - (k это keyword) man - читать мануал по какой то команде кратко. 

![image-20230912074613080](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912074613080.png)

`man clear` читать полный мануал по команде. чтобы искать нужно в открытом файле через консоль /'то что нужно найти'

`whatis uptime` - то же что и man -k

![image-20230912074835744](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912074835744.png)

`whereis` uptime - найти расположение команды

![image-20230912074906134](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912074906134.png)

`locate uptime` - найти файл с таким именем 

`ping ww.google.com` - проверить доступ этого сайта

![image-20230912075148343](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912075148343.png)

`ctrl + c` - убить и выйти из процесса

`ctrl + z` - не убивать процесс, но выйти 

`ps` - посмотреть какие процессы бегут в сеансе на момент вып. команды (тк исп ctrl + z для скрытия ping он выведен как бегущий процесс)

![image-20230912075243370](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912075243370.png)

`fg` - вернуться на бегущий процесс ( вернул отображение запущенного ping)

![image-20230912075348038](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912075348038.png)

## Навигация по Файлам и Директориям

В линуксе есть только `/`  - это самая корневая директория ($cd / $ls -la)

![image-20230912081728313](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912081728313.png)

`ls -la` - (l - longa, a -all ) - покажет подробную информацию о файлах и папках текщей директории  (в том числе скрытых)

`pwd` - print working directory 

![image-20230912082526136](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912082526136.png)

`cd` - перейти (`..` - вернуться на 1 директорию, `../..` - вернуться на 2 директории, `/` - в корень, без всего или `~` - домашняя директория пользователя)

## Работа с файлами - создание, копирование, перенос, переименование, стерание файлов

### Просмотр файлов

`cat file.txt`  - выведет в консоль содержание файла

`more file.txt` - выведет содержание файла (пролистывание по строчкам)

`less file.txt` - открыть файл

`touch` - обновить файл (может создать не существующую, если touch file.txt который уже существую, он просто измениь время его modified) 

### Копирование

`cp src dest -v`- копировать (что куда) флаг -v покажет куда они копируются

![image-20230912090037082](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912090037082.png)

`?`  -  это один любой знак, `*` - это любое количество любых знаков

Чтобы скопировать директорию в директорию нужен флаг -r (--recursive)

`cp dir2 NewDir -v -r`

![image-20230912090637388](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912090637388.png)

### Переименование

`mv file .file -v` - переименовать (. перед названием делает файл невидимым) 

![image-20230912090909482](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912090909482.png)

## Работа с директориями

`mkdir namedirectory` - создание, не создает полный путь только конечную

`mkdir -p dir3/dir4/dir5` - создает путь и конечную директорию

![image-20230912091254659](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912091254659.png)

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

![image-20230912093709877](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912093709877.png)

### Дубликат линоков (только для файлов)

`ln linux-history.txt linux-history_dublicate.txt` - создание полного дубликата, теперь если изменить один из файлов, изменения появятся и на другом 

видно что вывод записался в дубликат, но и в оригинале он есть

![image-20230912094615500](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912094615500.png)

##  Команды find, cut, sort, wc

`find src -name "что искать"` - поиск, сначала нужно указать где искать, потом через флаг -name "что искать" 

![image-20230912095046396](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912095046396.png)

`wc file.txt` - распечатать сколько в файле строк, слов и байт (-l только строк, -w только слов)

![image-20230912095558369](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912095558369.png)

`sort file.txt` - сортирует файл (-n сортировать по номерам)

![image-20230912100051092](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912100051092.png)

`cut -d "<" -f 2 linux-history_dublicate.txt` - если в файле есть разделение по какому то элементу, то можно вывести только часть файла -d (--delimiter=DELIM) -f (--fields=LIST) и указать в каком файле

![image-20230912100837365](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912100837365.png)

`|` - это pipe, после него можно записать команду для выполнения (получится конвеер)

![image-20230912101039463](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912101039463.png)

## Команда grep и Регулярные Выражения

`grep Linux ./*` - поиск по файлам, что искать (Linux) где искать (./* текущая директория все)

![image-20230912101657113](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912101657113.png)

`grep linux ./* -i` - доп флаг это игнорировать заглавные буквы  

![image-20230912102110794](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912102110794.png)

### Регулярные выражения 

Нужно построить патерн, строится он следующим образом, есть файл в котором например нужна почта

`grep .gov mydatfile.txt` - указываем что ищем строку оканчивающую на .gov

`grep [A-Za-z]*.gov mydatfile.txt` - указываем что перед точкой могут быть буквы от A до Z большие и маленькие, любые и скок угодно.

`grep -E"[A-Za-z].gov" mydatfile.txt` - E, --extended-regexp Интерпретировать ШАБЛОНЫ как расширенные регулярные выражения 

`grep -E"@[A-Za-z].gov" mydatfile.txt` - указываем что эти буквы после @ но до .gov

`grep -E"[A-Za-z\.]*@[A-Za-z].gov" mydatfile.txt` - указываем что перед @ могут быть любые буквы в том числе точки (точка обозначается так \.)

![image-20230912103039131](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912103039131.png)

![image-20230912103820429](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912103820429.png)

Если нужна почта не только .gov: `grep -E"[A-Za-z\.]*@[A-Za-z].(gov|mail)" mydatfile.txt`

## Перенаправление вывода / ввода - /dev/null

Перенаправить вывод и перезаписать

`sort linux-history.txt > sort_linux-history.txt` - если файла не было он создастся и в него запишется вывод, если файл уже существовал, то то что внутри перезапишется.

![image-20230912104221933](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912104221933.png)

`sort -n nymeric >> sort_linux-history.txt` -  добавление в конец файла

![image-20230912104740499](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912104740499.png)

Если сделать такую команду: `sort -n nymeric > nymeric` файл не станет сортированным, потому что тот файл в который будет записан вывод, сначала создается (пустым, тк в нем будет только вывод команды), а потом записывается команда, но т.к команда сортировки будет обращаться к пересозданному новому файлу, сортировать уже будет нечего.

Когда линукс выдает ответ, он выдает их в 2 потоках, хорошие и плохие. Их можно перенаправлять

`grep smvn /etc/* 2> errors.txt` - перенаправит ошибки в файл с ошибками, а хорошие ответы выдаст в консоль

![image-20230912110149526](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230912110149526.png)

`grep smvn /etc/* > good.txt 2> /dev/null` - перенаправление  хороших ответов в файл good, а ошибок в error

`grep smvn /etc/* &> results.txt` - перенаправит и хороший вывод и плохой в один файл. 

(Тк просто `>` это только хороший поток, а `2>` только плохой)

## Архивирование и Сжатие tar, gzip, bzip2, xz, zip

`tar cf mytar.tar Folder1` команда для архивирования, объединяет несколько файлов в один файл. (c - create; f - file ) f всегда должен быть последним, mytar.tar название файла архива, Folder1 - что будет лежать в архиве. Можно добавить -v чтоюы видеть что изменилось

![image-20230913104247050](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230913104247050.png)

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

![image-20230913110044217](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230913110044217.png)

Распаковка сжатых файлов такая же как и просто архив.

### Так же можно использовать ZIP

`zip -r myZIP.zip Folder1` - r необхдим чтобы взялись и внутренние файлы (рекурсивно) (самый тяжелый кратно)

 `unzip myZIP.zip`  - распокавать.

## Процессы и Память: top, free, ps

`top` - менеджер задач (task) в линукс (shift+p - отсортировать по cpu shift+m - отсортировать по памяти)

![image-20230914070521771](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914070521771.png)

`free -h` - посмотреть память -h (humon) в человеческом виде

![image-20230914072005708](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914072005708.png)

`ps` - посмотреть запущенные процессы (у него 3 флага -u указать юзера, -a все(all), -x детальнее и вместе с процессами команд запущенных в этой сессии)

![image-20230914072040756](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914072040756.png)

Все лог файлы хранятся в директории `/var/log`

Лог линукс ядра, он сущетвует только когда ВМ работает: `/var/log/dmesg`  (он в памяти, на диск не сохраняется)

## Типы аккаунтов и важные файлы

Типы аккаунтов:

- Standart
- Administrator - может использовать команды c sudo (тк он в группе sudo)
- Root - создается по умолчанию 

`/home` - создаются папки пользователя

`/etc/passwd` - файл в котором прописаны все пользователи (в том числе системные)

![image-20230914074537768](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914074537768.png)![image-20230914074553238](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914074553238.png)

`/etc/shadow` - тут лежат пароли

![image-20230914074938168](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914074938168.png)

![image-20230914074950087](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914074950087.png)

`/etc/group` - список групп и кто в них находится

![image-20230914075205455](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914075205455.png)

`whoami` - узнать имя текуще пользователя

![image-20230914075312421](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914075312421.png)

id - узнать id изера грппы и тех группы к которым юзер принадлежит

![image-20230914075448661](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914075448661.png)

`last` - выдаст кто делал и когда log in  

![image-20230914075618495](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914075618495.png)

`who` - какой юзер сейчас активен

![image-20230914075804901](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914075804901.png)

`w` - тоже самое что who только больше информации (чем занят юзер)

![image-20230914075915993](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914075915993.png)

## Пользователи и Группы

Пользователей может сосздавать юзер который входит в группу sudo (чтобы исп. права супер пользователя root)

`sudo useradd -m  user1` - создание пользователя (m создать home directory) 

![image-20230914081925993](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914081925993.png)

![image-20230914081939096](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914081939096.png)

Но у этогго пользователя нет пароля,об этом говорит файл etc/shadow, в него нельзя залогиниться

![image-20230914082129514](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914082129514.png)

`sudo passwd user1` - задать пароль юзеру

![image-20230914082235883](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914082235883.png)

И в  etc/shadow появился пароль

![image-20230914082315618](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914082315618.png)

Когда создается пользователь, на основе создающего юзера создается скелет (копируется)

`etc/skel` - директория которая копируется новым пользователям

`sudo userdel user1` - чтобы удалить только директорию user1, чтобы удалить все что связано, нужно удалить внутренние файлы и директории этого юзера, исп -r 

![image-20230914083732714](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914083732714.png)

`sudo groupadd Programmers` - создание группы (проверить в файле ../../etc/group)

![image-20230914084019578](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914084019578.png)

`sudo groupdel Programmers` - удалить группу

`sudo usermod -aG Programmers user2` - добавить изера в группу (a - append) 

![image-20230914084543448](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914084543448.png)

![image-20230914084527469](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914084527469.png)

![image-20230914084458905](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914084458905.png)

Можно добавлять в группу и через цифру

![image-20230914084824620](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914084824620.png)

`sudo deluser user2 sudo` - убрать из группы

![image-20230914085120068](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914085120068.png)

## Права Доступа и владения файлами и директориями

![image-20230914090254471](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914090254471.png)

Первый параметр - это указание прав на объект ( - --- --- --- )

`-` - может быть файлом (-), директорией (d) или линком (l)

Остальные пунктиры - это права для user group other (r (read), w (write), x (execute - выполнять))

`smvn smvn` - указание владельца и группы

`sudo chown user2 link_text1` - поменять владельца (change owner) (его права rw-)

![image-20230914090412256](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914090412256.png)

изменился файл, на который ссылается link (т.е. text1)

`sudo chgrp Pogrammers text1` - изменить группу (их права rw-)

![image-20230914090948602](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914090948602.png)

`sudo chmod o+x taxt1` - изменить права буквами (o - others x - execute)

![image-20230914091410617](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914091410617.png)

`sudo chmod u-w,g-w text1` - пример как убрать у нескольких

Можно изменять права цифрами

![image-20230914091636782](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914091636782.png)

`sudo chmod 777 text1` - (первая цифра это user)

![image-20230914092439065](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914092439065.png)

### sticky bit

В директории в которой все могут делать все, есть файлы, к которым закрыт доступ текущему пользователю он не может даже прочесть ничего

![image-20230914092843346](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914092843346.png)

Но поскольку директория разрешает делать все всем (ее права 777), любой может удалить файл который даже просмотреть не может

![image-20230914093003271](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914093003271.png)

Чтобы такого небыло, а управлять файлами мог только тот у кого есть права, директории для остальных можно дать право sticky bit (`o+t`) или через цифру (`0777` - 0 это убрать  `1777` - 1 это добавить)

`sudo chmod o+t Folder1` - дать наследование прав от файлов

![image-20230914093314222](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914093314222.png)

## Сетевые комманды

утилита ip

`ip addr` - узнать ip адресс вм

![image-20230914102713725](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914102713725.png)

Показывает что есть 3 сетевых устройства и информацию о них

`ip route` - запись в таблице маршрутизации (можно добавить в конце show)

![image-20230914134555512](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914134555512.png)

`ping -c 4 8.8.8.8` - команда пинг (адресс указа гугла www.google.com) флаг -c указвает сколько раз нужно обратиться на этот адрес (4 раза)

![image-20230914135048037](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914135048037.png)

`host` - вернет ip имени хоста

![image-20230914135340334](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914135340334.png)

`dig www.microsoft.com` - domain information groper, выведет информацию о домене

![image-20230914140348856](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914140348856.png)

`netstat` - показывает статистику приема и отправки пакетов, а также информацию об ошибках приема и отправки

![image-20230914141052018](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914141052018.png)

## Скачивание и Установка программ

`wget src` - (web get) скачивать из интернета (ссылка должна быть прямо до файла, скачивать можно по 1)

### Для Debian

`sudo apt-get install chromium-bsu` - скачивает и устанавливает пакет из репозитория

`whereis chromium-bsu` - чтобы узнать куда установился пакет 

![image-20230914144331864](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914144331864.png)

`sudo apt-get remove chromium-bsu` - удалить пакет

![image-20230914144627731](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914144627731.png)

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

## Скрипты Linux Bash Часть-1

Расширения скрипт файлов для линукс .sh

Файл всегда начинается шебанга (#!):

`#!/bin/bash` - указывает какого вида скрипт

![image-20230914155328402](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914155328402.png)

Файлу скрипту всегда нужно дать права на исполенение (x - execute). Но можно и не давать, тогда при запуске нужно указать (компилятор) `bash ./script1.sh`

![image-20230914155044525](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914155044525.png)

Чтобы запустить скрипт: `./script1.sh` то есть просто указать какой файл в данной директории.

Результат:

![image-20230914155630676](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914155630676.png)

**script2.sh**

Правила: Нельзя устанавливать пробелы для красоты, при присваивании значений переменным нужно писать слитно. Для того чтобы вывод какой то команды записался в переменную, ее нужно заключить в косые черты (это не одинарная ковычка, она находится где ё) - ``

чтобы сделать арифметическое действие ужно объявить что это переенные и в двойных скобках написать действие `$((...))` 

Для обращения к переменной в начале ее имени нужно указать `$name`  

![image-20230914162518387](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914162518387.png)

Результат

![image-20230914161149698](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914161149698.png)

Вообще `$0 = ./script2.sh`   `$1 = VOLODIMIR`  `$2 = SEMCHISHIN`

## Скрипты Linux Bash, Часть-2

### Условия 

начинаются с `if` и заканчиваются `fi` прописываются так:

`if [ ... ]; then ...`

`elif [ ... ]; then ....`

`else ...`

`fi`

![image-20230914165857868](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914165857868.png)

Но условие можно зписать иначе:

`case <какая то переменная> in`

`	<значение которому она может быть равана> ) <тогда сделать это> ;;`

`... ) ... ;;`

`... ) ...`

`esac`

Так же значения можно запрашивать в консоли через параметр `read`

Результат

![image-20230914165800060](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914165800060.png)

### Циклы

Цикл с пред условием**While**

Чтобы пользоваться циклом нужен счетчик (в примере это переменная COUNTER). В теле цикла он увеличивается (3 способа)

Шаблон такой:

`COUNTER=0`

`while [ <условие>]; do`

`<тело цикла>`

`COUNTER=$(($COUNTER+1))` 

`done` 

![image-20230914171505370](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914171505370.png)

Результат:

![image-20230914170918742](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914170918742.png)

### Цикл for

В данном случае кол-во итераций зависит от кол-ва найденных .txt файлов

![image-20230914172356211](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914172356211.png)

Результат (вывелось то что хранилось в файлах .txt текущей директории)

![image-20230914172433102](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914172433102.png)

Ниже пример цикла `for` когда количество итераций задается интервалом: 

![image-20230914172808454](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914172808454.png)

Результат

![image-20230914172832696](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914172832696.png)

Еще одна запись, но в формате языков си:

![image-20230914173109103](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914173109103.png)

Результат

![image-20230914173134862](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914173134862.png)

### Написание функции

Чтобы написать функцию ее нужно сначала объявить, а потом в ее теле написать действия

`<name>()`

`{`

`<тело функции>`

`}`

Чтобы ей воспользоваться ее нужно вызвать, в примере используются параметры $1 $2 они указываются сразу полсе вызова функции (как в консоли )

`<name> ... ...` 

![image-20230914174729419](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914174729419.png)

Результат:

![image-20230914174801187](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230914174801187.png)

## КРАТКАЯ ВЫЖИМКА ПО systemd

Systemd запускает сервисы описанные в его конфигурации.
Конфигурация состоит из множества файлов, которые по-модному называют юнитами.

Все эти юниты разложены в трех каталогах:

**/usr/lib/systemd/system/** – юниты из установленных пакетов RPM — всякие nginx, apache, mysql и прочее
**/run/systemd/system/** — юниты, созданные в рантайме — тоже, наверное, нужная штука
**/etc/systemd/system/** — юниты, созданные системным администратором — а вот сюда мы и положим свой юнит.

Юнит представляет из себя текстовый файл с форматом, похожим на файлы .ini Microsoft Windows.

![image-20230915141520376](https://github.com/VladimirSemchishin/DevOps_Practice/blob/main/For_photo/image-20230915141520376.png)

Для создания простейшего юнита надо описать три секции: [Unit], [Service], [Install]



## systemd 

набор базовых компонентов Linux-системы. Представляет собой менеджер системы и служб, который выполняется как процесс с PID 1 и запускает остальную часть системы. 

Главная команда для работы с `systemd` — `systemctl`. 

Она позволяет (среди прочего) отлеживать состояние системы и управлять системой и службами. 

- Для управления systemd на удалённой машине команды необходимо выполнять с ключом `-H *пользователь*@*хост*`. Соединение с удалённым процессом systemd будет установлено через [SSH](https://wiki.archlinux.org/title/OpenSSH_(Русский)).

Юнитами могут быть, например, службы (*.service*), точки монтирования (*.mount*), устройства (*.device*) или сокеты (*.socket*).

При работе с systemctl обычно необходимо указывать полное имя юнита с суффиксом, например, `sshd.socket`. Существует несколько возможных сокращений:

- Если суффикс не указан, systemctl предполагает, что это *.service*. Например, `netctl` равнозначно `netctl.service`.
- Точки монтирования автоматически преобразуются в юнит *.mount*. Например, `/home` равнозначно `home.mount`.
- Аналогично точкам монтрования, имена устройств автоматически преобразуются в юнит *.device*. Например, `/dev/sda2` равнозначно `dev-sda2.device`.

### 2.1) Обработка зависимостей 

В *systemd* зависимости определяются правильным построением файлов юнитов. Простой пример — юниту *A* требуется, чтобы юнит *B* был запущен перед запуском самого юнита *A*. Для этого добавьте строки `Requires=*B*` и `After=*B*` в раздел `[Unit]` юнит-файла *A*. Если зависимость является необязательной, укажите `Wants=*B*` и `After=*B*` соответственно. Обратите внимание, что `Wants=` и `Requires=` не подразумевают `After=`. Если `After=` не указать, то юниты будут запущены параллельно.

Зависимости обычно указываются для служб, но не для [целей](https://wiki.archlinux.org/title/Systemd_(Русский)#Цели). Так, цель `network.target` будет "подтянута" ещё на этапе настройки сетевых интерфейсов одной из соответствующих служб, и можно спокойно указывать эту цель как зависимость в пользовательской службе, поскольку `network.target` будет запущена в любом случае.

Службы различаются по типу запуска, и это следует учитывать при написании юнитов. Тип определяется параметром `Type=` в разделе `[Service]`:

- `Type=simple` (по умолчанию): *systemd* запустит эту службу незамедлительно. Процесс при этом не должен разветвляться (fork). Если после данной службы должны запускаться другие, то этот тип использовать не стоит (исключение — служба использует сокетную активацию).
- `Type=forking`: *systemd* считает службу запущенной после того, как процесс разветвляется с завершением родительского процесса. Используется для запуска классических демонов за исключением тех случаев, когда в таком поведении процесса нет необходимости. Укажите параметр `PIDFile=`, чтобы *systemd* мог отслеживать основной процесс.
- `Type=oneshot`: удобен для сценариев, которые выполняют одно задание и завершаются. Если задать параметр `RemainAfterExit=yes`, то *systemd* будет считать процесс активным даже после его завершения.
- `Type=notify`: идентичен параметру `Type=simple`, но с уточнением, что демон пошлет *systemd* сигнал готовности. Реализация уведомления находится в библиотеке *libsystemd-daemon.so*.
- `Type=dbus`: служба считается находящейся в состоянии готовности после появления указанного `BusName` в системной шине DBus.
- `Type=idle`: *systemd* отложит выполнение двоичного файла службы до окончания запуска остальных ("более срочных") задач. В остальном поведение аналогично `Type=simple`.

### 2.3) Редактирование файлов юнитов

Не стоит редактировать юнит-файлы пакетов напрямую, так как это приведёт к конфликтам с pacman. Есть два безопасных способа редактирования: создать новый файл, который полностью [заменит](https://wiki.archlinux.org/title/Systemd_(Русский)#Замещение_файла_юнита) оригинальный, или создать [drop-in файл](https://wiki.archlinux.org/title/Systemd_(Русский)#Drop-in_файлы), который будет применяться поверх оригинального юнита. В обоих случаях после редактирования необходимо перезагрузить юнит, чтобы изменения вступили в силу. Это выполняется либо путем редактирования блока с помощью команды `systemctl edit`, которая автоматически перезагружает юнит, либо перезагрузкой всех юнитов командой:

`$ systemctl daemon-reload`

#### Замещение файла юнита

Чтобы полностью заместить файл юнита `/usr/lib/systemd/system/*юнит*`, создайте файл с таким же именем `/etc/systemd/system/*юнит*` и [включите заново](https://wiki.archlinux.org/title/Systemd_(Русский)#Использование_юнитов) юнит для обновления символических ссылок.

Альтернативный способ: `systemctl edit --full юнит`

Эта команда откроет файл `/etc/systemd/system/*юнит*` в текстовом редакторе (если файл ещё не существует, будет скопирован оригинал) и автоматически перезагрузит юнит после завершения редактирования.



## systemd.timer

### Таймеры 

— файлы юнитов systemd, имя которых имеет суффикс .timer; они позволяют контролировать файлы .service или события. Таймеры имеют встроенную поддержку календарных и регулярных событий и могут запускаться в асинхронном режиме.

### 1) Юниты таймера

Таймеры *systemd* — файлы юнитов с суффиксом *.timer*. Они хранятся в тех же каталогах, что и другие [файлы настроек юнитов](https://wiki.archlinux.org/title/Systemd_(Русский)#Написание_файлов_юнитов), но включают в себя раздел `[Timer]`, который определяет, как и когда таймер запускается. Существует два типа таймеров:

- **Таймеры реального времени** запускаются в зависимости от событий календаря (как cronjobs). Для определения таких таймеров используется опция `OnCalendar=`.
- **Монотонные таймеры** - вкл. от отправной точи, не запустится если пк выключен

### 2) Юнит служб

Каждому файлу *.timer* соответствует файл *.service* (например, `foo.timer` и `foo.service`). *.timer* запускается и контролирует *.service*. *.service* не требует раздела `[Install]`, так как последний присутствует в юните *timer*, который уже включен. Если необходимо, то можно контролировать юниты с разным названием, используя опцию `Unit=` в таймере в разделе `[Timer]`.

### 3) Управление

Для того, чтобы использовать юнит-*timer*, [включите](https://wiki.archlinux.org/title/Включите) и [запустите](https://wiki.archlinux.org/title/Запустите) его, как любой другой юнит (не забудьте добавить суффикс *.timer*). Для того, чтобы увидеть все запущенные таймеры, выполните:

`$ systemctl list-timers` - чтобы увидеть и не запущенные флаг `-all`



