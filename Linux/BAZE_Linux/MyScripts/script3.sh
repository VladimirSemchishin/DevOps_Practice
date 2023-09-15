#!/bin/bash

if   [ "$1" == "Vasya" ]; then     #пробелы в [] обязательны
	echo "Privet $1"
elif [ "$1" == "Trump" ]; then 
	echo "Hello $1"
else echo "Вы не Вася и не Трамп"
fi



x=$2                                         #вводим переменную x и даем ей значение  2 параметра из консоли

echo "Starting CASE selection ..."
case $x in                                  #начало условия case
	1) echo "This is one";;             #если значение переменной x равно 1 
    [2-9]) echo "Two-nine";;                #если значение переменной x равно чему от 2 до 9
  "Petya") echo "Privet $x";;               #если значение переменной x равно Petya
        *) echo "Параметр мне не известен"  #если значение переменной x равно чему угодно
esac                                        #конец условия



echo "Please enter somthing: "   #ввод переменной из консоли
read x

read -p "Enter somthing:" x      #то же самое только короче
