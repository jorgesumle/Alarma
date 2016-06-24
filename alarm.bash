#!/bin/bash

now=$(date +%s)

while getopts ":d:m:" opt; do
	case $opt in
		d)
			deadline=$(date -d "$OPTARG" +%s)
			sec_left=$(($deadline-$now))
			if [ $sec_left -lt 1 ]; then
				echo "$OPTARG es una fecha anterior a la actual."
				exit 1
			fi
			;;
		m)
			if [[ -z $deadline ]]; then
				deadline=$((now+(60*$OPTARG)))
			else
				deadline=$((deadline+(60*$OPTARG)))
			fi
			sec_left=$(($deadline-$now))
			if [ $sec_left -lt 1 ]; then
				echo "$OPTARG no es un número positivo."
				exit 1	
			fi
			;;
		:)
			echo "La opción -$OPTARG requiere un valor."
			exit 1
			;;
	esac
done

while [ $sec_left -gt 0 ]; do
        clear
        echo "La fecha de la alarma es \"$(date --date=@$deadline)\"" 
	echo "La fecha actual es \"$(date)\"."
        let sec_left=$sec_left-1
	echo "$sec_left segundos restantes."
        sleep 1
done
echo -e '\a'		
