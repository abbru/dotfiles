#!/bin/sh
# Aplica un wallpaper con hyprpaper, en vivo y de forma persistente.
#
#   set-wallpaper.sh /ruta/imagen.png   -> la aplica Y la escribe en $wall
#   set-wallpaper.sh                    -> aplica lo que ya dice $wall
#
# El segundo modo existe porque hyprpaper lee hyprpaper.conf sólo al arrancar
# y no tiene reload por IPC: si editás $wall a mano, corré esto para verlo.
set -eu

conf="$HOME/.config/hypr/hyprpaper.conf"
persist=1

if [ "$#" -ge 1 ] && [ -n "$1" ]; then
	img=$1
else
	# Sin argumento: leer $wall del conf y sólo aplicarlo.
	img=$(sed -n 's|^\$wall = ||p' "$conf" | head -1)
	persist=0
	[ -n "$img" ] || { notify-send -a hyprpaper "Wallpaper" "No encontré \$wall en hyprpaper.conf"; exit 1; }
fi

# Expandir ~ para el chequeo y para el IPC.
case "$img" in
	"~/"*) img="$HOME/${img#\~/}" ;;
esac

[ -f "$img" ] || { notify-send -a hyprpaper "Wallpaper" "No existe: $img"; exit 1; }

# En caliente: hay que setearlo por monitor. El fallback de monitor vacío no
# alcanza, porque sólo aplica a salidas que nunca tuvieron target propio.
hyprctl -j monitors | jq -r '.[].name' | while read -r mon; do
	hyprctl hyprpaper wallpaper "$mon,$img" >/dev/null
done

if [ "$persist" -eq 1 ]; then
	if grep -q '^\$wall = ' "$conf"; then
		sed -i "s|^\$wall = .*|\$wall = $img|" "$conf"
	else
		notify-send -a hyprpaper "Wallpaper" "Aplicado, pero no encontré \$wall en hyprpaper.conf"
		exit 0
	fi
fi

notify-send -a hyprpaper "Wallpaper fijado" "$(basename "$img")"
