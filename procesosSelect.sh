#!/bin/bash

# Colores de opciones
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
NC='\e[0m'
LOG_FILE="/var/log/procesosSelect.log"
dates=$(date "+%b %d %H:%M:%S")

# Usuarios y credenciales
users=("f00001:Nombre Completo 1" "g00002:Nombre Completo 2" "h00003:Nombre Completo 3" "z00004:Nombre completo 4")

echo " "
read -p "Ingresa el password: " pass
echo "$dates Se ingreso con la cuenta: $pass" >> $LOG_FILE 2>&1
echo " "

for user in "${users[@]}"; do
    IFS=":" read -r user_id user_name <<< "$user"

    if [ "$pass" == "$user_id" ]; then
        echo -e "${GREEN}Bienvenido: $user_name${NC}"
        
        opc=0  # Inicializar opción para while
	echo "$dates EL Usuario $user inicio sesion" >> $LOG_FILE 2>&1

        while [ $opc -ne 4 ]; do
	    # Menu
            echo " "
            echo "1 - Proceso RAM"
            echo "2 - Proceso CPU"
            echo "3 - Proceso Almacenamiento"
            echo "4 - Exit"
            echo " "
            read -p "Elige una opcion: " opc
	    echo "$dates El usuario $user selecciono la opcion $opc" >> $LOG_FILE 2>&1
            echo " "
	    # Ejecucion de la opciones del menu
            if [ $opc -eq 1 ]; then
                echo -e "${YELLOW}Mostrando uso de RAM:${NC}"
		echo " "
		echo "$dates El usuario $user ejecuto el Proceso RAM" >> $LOG_FILE 2>&1
                free -hw
            elif [ $opc -eq 2 ]; then
                echo -e "${YELLOW}Mostrando uso de CPU:${NC}"
		echo " "
		echo "$dates El usuario $user ejecuto el Proceso CPU" >> $LOG_FILE 2>&1
                ps -eo pid,psr,pcpu,comm --sort=-pcpu | head -n 10
            elif [ $opc -eq 3 ]; then
                echo -e "${YELLOW}Mostrando uso de ALMACENAMIENTO:${NC}"
		echo " "
		echo "$dates El usuario $user ejecuto el Proceso Almacenamiento" >> $LOG_FILE 2>&1
		df -hT
            elif [ $opc -eq 4 ]; then
                echo -e "${GREEN}Bye${NC}"
		echo "$dates El usuario $user salio del Programa" >> $LOG_FILE 2>&1
                exit 0
            else
                echo -e "${RED}Opcion INCORRECTA !!${NC}"
		echo "$dates El usuario $user preciono una opcion NO valida" >> $LOG_FILE 2>&1
            fi
        done
    fi
done

echo -e "${RED}Password INCORRECTO !!${NC}"
echo "$dates El usuario $pass es Incorrecto" >> $LOG_FILE 2>&1

