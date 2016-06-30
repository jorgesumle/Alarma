# Descripción simple
Es un programa de línea de órdenes que puede ser utilizado como alarma.
# Sinopsis
./alarma [OPCIÓN]... [TIEMPO]
# Descripción detallada
Alarma obtiene el momento actual a partir de la instrucción `date +%s`. A partir del momento actual y del momento de activación de la alarma indicado, se iniciará una cuenta atrás. Si no se indica el tiempo para la activación, la alarma se activará de inmediato. El sonido de la alarma es el mismo que utiliza el sistema operativo como alerta (`echo -ne "\a"`). Si no está activado, no sonará nada cuando acabe la cuenta atrás de la alarma; pero aparecerá la pantalla de la alarma. Para salir de esta pantalla, se debe pulsar cualquier tecla excepto la BARRA ESPACIADORA o ENTER.
#Instalación
Debes tener Bash instalado. Descarga el archivo con la extensión .bash, dale permisos de ejecución (`chmod u+x alarma.bash`) y ejecútalo (`./alarma.bash`); o bien ejecutálo directamente con bash (`bash alarma.bash`).
