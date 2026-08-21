-- ~/.config/swayimg/init.lua  ->  dotfiles/.config/swayimg/init.lua
-- swayimg 5.x se configura en Lua. Referencia: man swayimg
-- API: swayimg.viewer / swayimg.gallery, .on_key(), .get_image()

-- Paleta oscura, igual que imv y el lockscreen
swayimg.gallery.thumb_size = 220
swayimg.gallery.window_color = 0xff0d0d0d
swayimg.gallery.unselected_color = 0xff1a1a1a
swayimg.gallery.selected_color = 0xff262626
swayimg.gallery.border_color = 0xff33ccff -- el accent de lookandfeel.lua
swayimg.gallery.selected_scale = 1.15

-- Escapar para /bin/sh, por si alguna ruta trae comillas o espacios
local function shquote(s)
	return "'" .. s:gsub("'", "'\\''") .. "'"
end

-- Fija la imagen actual como wallpaper, con el mismo script que usa imv.
local function set_wallpaper(img)
	if not img or not img.path then
		return
	end
	local script = os.getenv("HOME") .. "/.config/hypr/scripts/set-wallpaper.sh"
	-- El & evita que swayimg se quede esperando al script.
	os.execute(shquote(script) .. " " .. shquote(img.path) .. " &")
end

-- Shift+W fija el wallpaper, tanto en la galería como viendo una imagen sola.
swayimg.gallery.on_key("Shift+w", function()
	set_wallpaper(swayimg.gallery.get_image())
end)

swayimg.viewer.on_key("Shift+w", function()
	set_wallpaper(swayimg.viewer.get_image())
end)
