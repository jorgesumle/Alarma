#!/bin/bash
# Alarma es un programa para interfaz de línea de órdenes que sirve de alarma.
# Copyright (C) 2016 Jorge Maldonado Ventura

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

usage(){
	echo "Alarma es un programa de línea de órdenes que puede ser utilizado como alarma."
	echo
	echo "Uso: alarma [OPCIÓN]... [TIEMPO]"
}

now=$(date +%s)
frecuency=0.5

while getopts ":-:d:m:f:" opt; do
	case $opt in
		-)
			if [ $OPTARG = "version" ]; then
				echo "Alarma 0.1"
				exit
			elif [ $OPTARG = "help" ]; then
				usage	
				exit
			fi
			;;
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
		f)
			pos_num_regex='^[0-9]+([.][0-9]+)?$'
			if ! [[ $OPTARG =~ $pos_num_regex ]]; then
				echo "La frecencia debe ser un número positivo."
				exit 1
			else
				frecuency=$OPTARG
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
while [ -z "$stop" ]; do 
	clear
	echo "Pulsa una letra para continuar."
 	echo -ne "\a"
	read -n1 -t$frecuency stop; 
done
