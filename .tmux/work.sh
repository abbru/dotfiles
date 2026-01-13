#!/bin/bash

SESSION_NAME="workspace"

# Nombres personalizados de las 4 ventanas
WIN1=""      # layout personalizado
WIN2=""
WIN3=""
WIN4=""

# Comprobá si la sesión ya existe
tmux has-session -t "$SESSION_NAME" 2>/dev/null
if [ $? -ne 0 ]; then
  # Crear sesión con primera ventana
  tmux new-session -d -s "$SESSION_NAME" -n "$WIN1"

   # Pane 0 (izquierda)
   tmux split-window -h          # crea Pane 1 a la derecha
    tmux resize-pane -t 0 -x 40   # ancho fijo izquierdo

   # Pane 1 → dividirlo en Pane 2 y 3 hacia abajo
   tmux select-pane -t 1
   tmux split-window -v          # Pane 2 debajo de Pane 1
   tmux select-pane -t 2
   tmux split-window -v          # Pane 3 debajo de Pane 2

  # Ahora tenemos: Pane 0 (izq), Pane 1 (arriba der), Pane 2 (medio der), Pane 3 (abajo der)

   # Ajustamos las alturas a mano (asumiendo 3 iguales de lado derecho)
   tmux resize-pane -t 1 -y 10
   tmux resize-pane -t 2 -y 10
   # Pane 3 quedará con el resto del espacio automáticamente

fi

# Crear otras ventanas si no existen
tmux new-window -t "$SESSION_NAME" -n "$WIN2"
tmux new-window -t "$SESSION_NAME" -n "$WIN3"
tmux new-window -t "$SESSION_NAME" -n "$WIN4"

# Conectarse a la sesión (si ya estás en tmux, cambiar de sesión; si no, attach)
if [ -n "$TMUX" ]; then
  tmux switch-client -t "$SESSION_NAME"
else
  tmux attach -t "$SESSION_NAME"
fi

