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
	cat << _EOF_
Modo de empleo: alarma [OPCIÓN]... [TIEMPO]

Alarma obtiene el momento  actual a partir de la instrucción 'date +%s'. A partir del momento actual  y del  momento de activación de la alarma indicado, se iniciar una cuenta atrás. Si no se indica el  tiempo para  la activación, la alarma se activar de inmediato.

El sonido de la alarma es el mismo que  utiliza  el sistema  operativo como alerta ('echo -ne ""'). Si no está activado, no sonará nada cuando acabe la  cuenta atrás  de la alarma; pero aparecer la pantalla de la alarma. Para salir de esta pantalla, se debe pulsar cualquier  tecla  excepto  la  BARRA  ESPACIADORA o ENTER.

Se pueden combinar diferentes opciones para establecer el tiempo de activación de la alarma. Incluso se puede restar tiempo a la alarma tras establecer el tiempo de activación en una unidad de mayor duración (por ejemplo, 'alarma -m 1 -s -30' activa la alarma en 30 segundos). La opción -d también permite hacer uso de esta funcionalidad. 

       -d     Establece el momento de activación a una fecha (e.g. 14:06, mar jul  5 02:50:14 CEST 2016)

       -f     La frecuencia a la que suena la alarma una vez activada en segundos

       -h     La alarma se activará en el número de horas indicado

       -m     La alarma se activará en el número de minutos indicado

       -s     La alarma se activará en el número de segundos indicado

       --version
              Muestra la información de la versión y sale del programa

       --help Muestra esta ayuda y sale del programa

AUTOR
       Escrito por Jorge Maldonado Ventura.

INFORMAR DE ERRORES
       Envíe, por favor, los errores y sugerencias a <jorgesumle@freakspot.net>.

COPYRIGHT
       Copyright © 2016 Free Software Foundation, Inc.  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
       This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.
_EOF_
}

pos_num_req_error (){
	echo "$OPTARG no es un número positivo. Para esta opción solo es admisible un número positivo."
	exit 1
}

now=$(date +%s)
frecuency=0.5

while getopts ":-:d:h:m:s:f:" opt; do
	case $opt in
		-)
			if [ $OPTARG = "version" ]; then
				echo "Alarma 0.2"
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
		h)
			if [[ -z $deadline ]]; then
				deadline=$((now+(60*60*$OPTARG)))
			else
				deadline=$((deadline+(60*60*$OPTARG)))
			fi
			sec_left=$(($deadline-$now))
			if [ $sec_left -lt 1 ]; then
				pos_num_req_error
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
				pos_num_req_error 
			fi
			;;
		s)
			if [[ -z $deadline ]]; then
				deadline=$((now+$OPTARG))
			else
				deadline=$((deadline+$OPTARG))
			fi
			sec_left=$(($deadline-$now))
			if [ $sec_left -lt 1 ]; then
				pos_num_req_error 
			fi
			;;
		f)
			pos_num_regex='^[0-9]+([.][0-9]+)?$'
			if ! [[ $OPTARG =~ $pos_num_regex ]]; then
				pos_num_req_error
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
