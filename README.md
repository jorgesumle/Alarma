# Descripción simple
Es un programa de línea de órdenes que puede ser utilizado como alarma.
# Sinopsis
./alarma.bash [OPCIÓN]... [TIEMPO]
# Descripción detallada
Alarma obtiene el momento actual a partir de la instrucción `date +%s`. A partir del momento actual y del momento de activación de la alarma indicado, se iniciará una cuenta atrás. Si no se indica el tiempo para la activación, la alarma se activará de inmediato. 

El sonido de la alarma es el mismo que utiliza el sistema operativo como alerta (`echo -ne "\a"`). Si no está activado, no sonará nada cuando acabe la cuenta atrás de la alarma; pero aparecerá la pantalla de la alarma. Para salir de esta pantalla, se debe pulsar cualquier tecla excepto la BARRA ESPACIADORA o ENTER.

Se pueden combinar diferentes opciones para establecer el tiempo de activación de la alarma. Incluso se puede restar tiempo a la alarma tras establecer el tiempo de activación en una unidad de mayor duración (por ejemplo, `alarma -m 1 -s -30` activa la alarma en 30 segundos). La opción -d también permite hacer uso de esta funcionalidad.
#Parámetros disponibles
       -d     Establece el momento de activación a una fecha (e.g. 14:06, mar jul  5 02:50:14 CEST 2016)

       -f     La frecuencia a la que suena la alarma una vez activada en segundos

       -h     La alarma se activará en el número de horas indicado

       -m     La alarma se activará en el número de minutos indicado

       -s     La alarma se activará en el número de segundos indicado

       --version
              Muestra la información de la versión y sale del programa.

       --help Muestra la información de la ayuda y sale del programa.
#Instalación
Debes tener Bash instalado. Descarga el archivo con la extensión .bash, dale permisos de ejecución (`chmod u+x alarma.bash`) y ejecútalo (`./alarma.bash`); o bien ejecútalo directamente con bash (`bash alarma.bash`).

Para acceder a la página de manual simplemente con la instrucción `man alarma`, mueve el archivo `alarma.1.gz` a la carpeta donde se encuentran los manuales en tu equipo (`e.g. sudo cp alarma.1.gz /usr/share/man/man1`).
