-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
--
-- Único lugar donde se levantan los daemons del ecosistema Hypr.
-- Los .service de systemd de estos programas quedan DESHABILITADOS a propósito:
-- si habilitás alguno, sacalo de acá o vas a terminar con dos instancias.

hl.on("hyprland.start", function()
	-- Idle: bloqueo, atenuado, dpms y suspensión -> hypridle.conf
	hl.exec_cmd("pidof hypridle || hypridle")

	-- Wallpaper con rotación aleatoria -> hyprpaper.conf
	hl.exec_cmd("pidof hyprpaper || hyprpaper")

	-- Filtro de luz azul por horario -> hyprsunset.conf
	hl.exec_cmd("pidof hyprsunset || hyprsunset")

	-- Agente polkit: sin esto las apps gráficas no pueden pedir privilegios.
	-- El binario está en /usr/lib/hyprpolkitagent, fuera del PATH, así que se
	-- arranca por su unit (start, no enable).
	hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
end)
