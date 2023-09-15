#!/bin/bash
#=====Скрипт резервного копирования=====









DATETIME=`date +date_%d_%m_%y-time_%H_%M_%S`	#метка времени дата-время

addr=`pwd`

SRC=$addr/$1
GIVENAME=$2
DST=$addr/$3

echo -e "\n=====  Перечислены значения переменных  =====\n"
echo -e "\nРабочая директория: \n$addr"
echo -e "\nАдресс папки архивирования и сжатия: \n$SRC"
echo -e "\nАдресс папки назначения: \n$DST"
echo -e "\nИмя которое вставится в название файла: \n$GIVENAME\n"


echo -e "\n=====  Проверка наличия архиватора <tar>  =====\n"

check=`find /usr/bin/ -name "tar"`
#echo $check

check_tar()
{
	if [ "$check" == "/usr/bin/tar" ]; then
		echo -e "\nАрхиватор установлен, все хорошо. Вот его версия:\n"
		tar --version
	else
		echo "Архиватор <tar> не установлен, сделайтей это сами или разкоментируйте строку 36 скрипт-файла"
		#sudo apt-get install tar
	fi
}
check_tar


echo -e "\n=====  Cоздание архива и его сжатие  =====\n"

tarandzip() 					
{
	tar -cjvf $DATETIME-$GIVENAME.bz $SRC
	mv  $addr/$DATETIME-$GIVENAME.bz $DST
	#sort $DST
	echo -e "\nФайл архив --->  $DATETIME-$GIVENAME.bz\n"
	tree
}
tarandzip 

kol_vo=`ls backup_year/ | wc -l`

if [ "$kol_vo" > 4 ]; then
		echo "кол-во больше 4"
		echo "А именно $kol_vo"
else
	 echo "кол-во меньше или равно 4"
	 echo "А именно $kol_vo"
fi















