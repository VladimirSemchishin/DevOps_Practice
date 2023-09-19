#!/bin/bash


##########Определение даты и времени
DATETIME=`date +date_%d_%m_%y-time_%H_%M_%S`


##########Запрос адреса назначения
read -p "Введите путь до места хранения: " DST #это файл с всеми бэкапами
read -p "Введите Имя файла: " NAME
read -p "Введите путь до архивируемой директории: " SRC
#echo $DST

##########Проверка наличия архиватора
check=`find /usr/bin/ -name "tar"`
CheckTar()
{
	if [ "$check" == "/usr/bin/tar" ]; then
		echo -e "\nАрхиватор установлен. Вот его версия:\n"
		tar --version
	else
		echo "Архиватор <tar> не установлен, его нужно установить."
		#sudo apt-get install tar
	fi
}
#CheckTar


##########Архивирование
TarAndZip() 					
{
	tar -cjvf $DATETIME-$NAME.bz $SRC
}
#TarAndZip 

##########Перенос файла (узнает адрес созданного файла и переносит в DST)
MoveTarFile() 
{
  path_tarfile=`whereis $DATETIME-$NAME.bz`
  mv $path_tarfile DST
}
#MoveTarFile

##########Определение последней директории пути
NameLastDir=`basename $()`
