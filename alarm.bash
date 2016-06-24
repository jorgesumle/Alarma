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
