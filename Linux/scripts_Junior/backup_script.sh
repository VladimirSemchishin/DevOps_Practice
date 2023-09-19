#!/bin/bash
#=====Скрипт резервного копирования=====


DATETIME=`date +date_%d_%m_%y-time_%H_%M_%S`	#метка времени дата-время

addr=`pwd`

SRC=$addr/$1
GIVENAME=$2
DST=$addr/$3 #заранее оговоренная директория

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
}
tarandzip 

# 6 дневных backup_day в 23:34
# 4 недельных backup_week 23:33
# 3 месячных backup_month 23:32
# 1 годовая backup_year 23:31 - date_31_12



kol_vo=`ls backup_year/ | wc -l`

for_dir_backup_w=`ls | grep -E "time[_0-9]{6}" "date[_0-9]{6}"` #для опр. недельного бэкапа

case $x in 
	

esac

			if [ "$kol_vo" > 4 ]; then
					echo "кол-во больше 4"
					echo "А именно $kol_vo"
			else
				 echo "кол-во меньше или равно 4"
				 echo "А именно $kol_vo"
			fi





# перебор директорий 
kol_vo_dir=`ls DST | wc -l`
if  [ "kol_vo_dir" == 0 ]; then #если скрипт выполняется впервые и директорий разделенных по времени нет
		mkdir backup_day backup_week backup_month backup_year
		check_tar
		tarandzip










