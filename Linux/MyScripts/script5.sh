#!/bin/bash

summa=0

myFunction()                             #описать функцию
{
	echo "This is next from Function"
	echo "Num1 = $1"
	echo "Num2 = $2"
	summa=$(($1+$2))
}


myFunction  50 60                            #вызвать функцию
echo "Summa = $summa"
