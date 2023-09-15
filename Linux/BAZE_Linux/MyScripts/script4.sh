#!/bin/bash

COUNTER=0

while [ $COUNTER -lt 10 ]; do    #пока меньше 10
	echo "Current counter is $COUNTER"
	#COUNTER=$(($COUNTER+1))
	#let COUNTER=COUNTER+1
	let COUNTER+=1
done

for e in `ls *.txt`; do     #вводится переменная e и в нее по очереди будет записываться значение вывода команды, кол-во итераций цикла зависит от кол-ва найденных файлов .txt
	cat $e              #напечатать переменную e
done


for x in {1..10}; do        #явно определенный интервал от 1 до 10 включительно
	echo "X = $x"
done


for (( i=1; i<=10; i++ )); do #цикл в формате языков си
	echo "Nomer I = $i"
done
