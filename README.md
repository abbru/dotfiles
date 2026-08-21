# Dotfiles

Configuración personal para Arch Linux + Wayland: **Hyprland** como compositor
(configurado en Lua), **foot** y **kitty** como terminales, **fish** y **zsh**
como shells, **tmux** como multiplexor y **Neovim** (lazy.nvim) como editor.

El repo está pensado para desplegarse con [GNU Stow](https://www.gnu.org/software/stow/):
su raíz **espeja `$HOME`**, así que cada archivo del repo termina como symlink en
la misma ruta relativa dentro de tu home.

```
dotfiles/
├── .config/
│   ├── fish/config.fish          shell interactivo principal
│   ├── foot/foot.ini             terminal por defecto de Hyprland
│   ├── kitty/{kitty.conf,color.ini}
│   ├── hypr/
│   │   ├── hyprland.lua          entrada; hace require de barba/*.lua
│   │   ├── barba/*.lua           monitors, autostart, input, lookandfeel,
│   │   │                         misc, keybindings, workspaces, enviroment
│   │   ├── hyprlock.conf         pantalla de bloqueo
│   │   ├── hypridle.conf         atenuado / lock / dpms / suspend
│   │   ├── hyprpaper.conf        wallpaper (modo fijo, rotación comentada)
│   │   ├── hyprsunset.conf       filtro de luz azul por horario
│   │   └── scripts/set-wallpaper.sh
│   ├── imv/config                visor de imágenes (Shift+W fija wallpaper)
│   ├── swayimg/init.lua          galería de wallpapers (Shift+W idem)
│   └── nvim/                     init.lua + lua/barba/{core,plugins,lsp}
├── .tmux.conf
├── .tmux/work.sh                 sesión "workspace" de 4 ventanas
└── .zshrc
```

## 1. Qué instalar

### Repos oficiales

```sh
# Base
sudo pacman -S stow git base-devel

# Hyprland y su ecosistema
sudo pacman -S hyprland hyprpaper hyprlock hypridle hyprsunset hyprpicker \
               hyprcursor hyprpolkitagent xdg-desktop-portal-hyprland

# Utilidades del escritorio que usan los keybinds y los scripts
sudo pacman -S fuzzel thunar swaync libnotify \
               grim slurp swappy wl-clipboard \
               brightnessctl playerctl jq \
               pipewire pipewire-pulse wireplumber   # wpctl (volumen)

# Terminales
sudo pacman -S foot kitty

# Shells
sudo pacman -S fish starship \
               zsh zsh-syntax-highlighting zsh-autosuggestions

# Editor, multiplexor y CLI
sudo pacman -S neovim tmux lazygit ripgrep fzf bat eza lsd

# Toolchains que necesitan los LSP/formatters de Mason
sudo pacman -S nodejs npm python go

# Visores de imágenes (selector de wallpapers)
sudo pacman -S imv swayimg
```

### Fuentes

```sh
sudo pacman -S ttf-cascadia-code-nerd \   # kitty, imv, hyprlock
               ttf-jetbrains-mono-nerd \  # foot
               ttf-rubik-vf               # UI de hyprlock
```

### AUR (`yay`)

```sh
yay -S zen-browser-bin \                  # navegador de SUPER + B
       zsh-theme-powerlevel10k-git        # prompt de zsh
```

### Opcionales

- `zoxide` y `direnv`: `config.fish` los engancha sólo si existen en el PATH.
- `quickshell-git` / caelestia: `config.fish` lee
  `~/.local/state/caelestia/sequences.txt` si está presente, y lo ignora si no.

## 2. Desplegar con stow

```sh
git clone https://github.com/<tu-usuario>/dotfiles.git ~/dotfiles
cd ~/dotfiles

stow -nvt ~ .   # SIMULACRO: muestra qué haría, sin tocar nada
stow -vt ~ .    # crea los symlinks
```

`-t ~` fija el destino en tu home y `.` es el "paquete" (la raíz del repo).
Corriendo desde `~/dotfiles` el destino por defecto ya es `~`, así que
`stow .` alcanza; el `-t` explícito evita sorpresas si lo llamás desde otro lado.

Stow **no pisa archivos existentes**: si ya tenés un `~/.zshrc` o un
`~/.config/nvim/init.lua` reales, aborta con un conflicto. Dos salidas:

```sh
mv ~/.zshrc ~/.zshrc.bak && stow -vt ~ .   # apartás el tuyo y volvés a intentar

stow --adopt -vt ~ .                       # mueve los archivos del sistema
git diff                                   # AL repo; revisá y descartá con
                                           # git checkout -- . si no querías eso
```

Comandos del día a día:

| Comando | Para qué |
|---|---|
| `stow -Rvt ~ .` | re-enlazar tras agregar archivos nuevos al repo |
| `stow -Dvt ~ .` | quitar todos los symlinks |
| `stow -nvt ~ .` | simulacro (combinable con `-R` / `-D`) |

Si un directorio ya existe en `~` (por ejemplo `~/.config`), stow enlaza archivo
por archivo dentro de él; si no existe, enlaza el directorio entero.

## 3. Después de stow

**tmux** — los plugins están commiteados como gitlinks y el repo no tiene
`.gitmodules`, así que al clonar quedan vacíos. Instalá TPM y dejá que él baje el
resto:

```sh
git clone https://github.com/tmux-plugins/tpm ~/dotfiles/.tmux/plugins/tpm
tmux source ~/.tmux.conf
# dentro de tmux: prefix (Ctrl+B) + I  -> instala tmux-yank y tmux-kanagawa
```

**Neovim** — abrí `nvim`: lazy.nvim se auto-instala y Mason baja LSPs
(`ts_ls`, `html`, `cssls`, `tailwindcss`, `svelte`, `astro`, `lua_ls`, `graphql`,
`emmet_ls`, `prismals`, `pyright`, `eslint`, `gopls`, `templ`) y herramientas
(`prettier`, `stylua`, `isort`, `black`, `pylint`, `eslint_d`, `goimports`,
`gofumpt`, `gomodifytags`). Estado con `:Lazy` y `:Mason`.

**Shells** — el login shell del sistema sigue siendo el que tengas; foot arranca
`fish`, kitty arranca `zsh` y tmux usa `fish` para sus paneles. Para que fish sea
también el de login:

```sh
chsh -s /usr/bin/fish
```

**Hyprland** — cerrá sesión y entrá de nuevo (o `hyprctl reload`). El autostart
levanta `hypridle`, `hyprpaper`, `hyprsunset` y `hyprpolkitagent`; los `.service`
de systemd de esos programas deben quedar **deshabilitados** o vas a terminar con
dos instancias de cada uno.

**Wallpapers** — `hyprpaper.conf` apunta a `~/Pictures/Wallpapers`; creá la
carpeta y poné imágenes ahí. `SUPER + W` abre la galería de swayimg y `Shift+W`
fija la que estés viendo (el script actualiza `$wall` en `hyprpaper.conf`, así que
sobrevive al reinicio).

## 4. Qué hay configurado

### Hyprland

Config partida en módulos Lua bajo `.config/hypr/barba/`. Monitores: `eDP-1` y
`HDMI-A-2` a 1920x1080. Layout `dwindle`, gaps 5/20, bordes con degradé
cian→verde, rounding 10, blur y sombras, animaciones con curvas custom.

Keybinds principales (`mainMod` = SUPER):

| Bind | Acción |
|---|---|
| `SUPER + T` / `B` / `E` / `R` | foot · zen-browser · thunar · fuzzel |
| `SUPER + Q` | cerrar ventana |
| `SUPER + F` / `M` | fullscreen · maximizar |
| `SUPER + V` / `O` / `U` | flotante · pseudo · togglesplit |
| `SUPER + H/J/K` y flechas | mover foco |
| `SUPER + 1..0` / `+ SHIFT` | ir a workspace · mover ventana |
| `SUPER + L` | bloquear (hyprlock) |
| `SUPER + P` | captura de región → swappy |
| `SUPER + SHIFT + S` | captura de región → portapapeles |
| `SUPER + SHIFT + C` | cuentagotas, hex al portapapeles |
| `SUPER + W` | galería de wallpapers |
| `SUPER + click izq/der` | mover / redimensionar |

Teclas multimedia: volumen y mute vía `wpctl`, brillo vía `brightnessctl`,
play/next/prev vía `playerctl`.

Reglas de ventana: se suprimen los eventos de maximizar, fix de drags en
XWayland, y `imv`/`swayimg` salen flotantes y centrados al 70% del monitor.

**Idle** (`hypridle.conf`): 2:30 atenúa, 5:00 bloquea, 5:30 apaga pantallas,
30:00 suspende. **hyprsunset**: sin filtro a las 7:00, 4500K a las 20:30.
**hyprlock**: fondo con captura desenfocada, reloj, fecha, avatar
(`~/.face`), campo de contraseña, y batería (`BAT1`) sólo en `eDP-1`.

### Terminales

- **foot** (el de los keybinds): fish, JetBrains Mono Nerd 12, 10k líneas de
  scrollback, cursor beam, transparencia 0.78 con blur, `Ctrl+Shift+F` busca.
- **kitty**: zsh, CaskaydiaCove Nerd Mono 13, tema en `color.ini`, tab bar
  powerline, opacidad 0.95, navegación entre ventanas con `Ctrl+a/d/w/s`.

### Shells

- **fish**: prompt starship, `zoxide` como `cd`, `direnv`, `ls` = `eza --icons`,
  y abreviaciones de git (`gs`, `ga`, `gc`, `gp`, `gpl`, `gsw`, `lg`…).
- **zsh**: powerlevel10k, syntax-highlighting, autosuggestions, `fzf` con preview
  (`fzf-lovely`), alias a `lsd` y `bat`, historial compartido de 10k.

### tmux

Prefix por defecto, status bar arriba, tema kanagawa, `tmux-yank`, mouse on,
ventanas desde 1, `fish` como shell, `prefix + Ctrl+O` abre `claude` en un panel
partido, `Ctrl+Alt+hjkl` redimensiona y `prefix + hjkl` navega paneles/ventanas.
`.tmux/work.sh` arma la sesión `workspace` con 4 ventanas y un layout de 4 paneles.

### Neovim

`init.lua` → `barba.core` (opciones y keymaps, leader = espacio, `jk` sale de
insert) + `barba.lazy` + `barba.lsp`. Tema **kanagawa** (wave). 42 plugins
fijados en `lazy-lock.json`: telescope (+fzf-native), nvim-tree, bufferline,
lualine, alpha, treesitter (+textobjects, autotag), nvim-cmp con LuaSnip,
mason/mason-lspconfig/mason-tool-installer, conform (format on save), nvim-lint
(pylint), gitsigns, lazygit, trouble, todo-comments, surround, substitute,
autopairs, indent-blankline, auto-session, dressing, vim-maximizer,
vim-tmux-navigator y copilot.lua (`M-j` acepta la sugerencia).
