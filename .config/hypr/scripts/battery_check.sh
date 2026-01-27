#!/bin/bash

send_hypr_notify() {
    hyprctl notify "$1" 5000 "rgb($2)" "$3"
}

BAT_PATH=$(find /sys/class/power_supply/ -name "BAT*" | head -n 1)

# Inicialización
# Usamos una variable para detectar si tenemos corriente externa (AC)
# Algunos sistemas usan 'Full' cuando está enchufado pero al 100%
get_status() {
    local status=$(cat "$BAT_PATH/status")
    echo "$status"
}

LAST_STATUS=$(get_status)

while true; do
    CAPACITY=$(cat "$BAT_PATH/capacity")
    CURRENT_STATUS=$(get_status)

    # --- Lógica de Cambio de Estado (Conectar/Desconectar) ---
    if [ "$CURRENT_STATUS" != "$LAST_STATUS" ]; then
        
        # Si pasa de algo a Charging o Full, es que se conectó
        if [[ "$CURRENT_STATUS" == "Charging" || "$CURRENT_STATUS" == "Full" ]]; then
            send_hypr_notify 0 "00FFCC" "🔌 Energía Conectada ($CAPACITY%)"
        
        # Si pasa de Charging/Full a Discharging, es que se desconectó
        elif [[ "$CURRENT_STATUS" == "Discharging" ]]; then
            send_hypr_notify 2 "FFA500" "🔋 Usando Batería ($CAPACITY%)"
        fi
        
        LAST_STATUS="$CURRENT_STATUS"
    fi

    # --- Lógica de Niveles Críticos ---
    if [ "$CURRENT_STATUS" == "Discharging" ]; then
        if [ $CAPACITY -le 5 ]; then
            send_hypr_notify 1 "FF5555" "🔴 CRÍTICO: $CAPACITY%. ¡Conecta YA!"
            sleep 10
            continue
        elif [ $CAPACITY -le 10 ]; then
            send_hypr_notify 2 "FF5555" "⚠️ Batería muy baja: $CAPACITY%"
        elif [ $CAPACITY -le 15 ]; then
            send_hypr_notify 0 "FFA500" "Aviso de Batería: $CAPACITY%"
        fi
    fi

    sleep 2 # Bajamos a 2 segundos para que la respuesta sea instantánea
done
