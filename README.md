# Dotfiles

This repository contains my personal dotfiles configuration for a customized Linux desktop environment using Hyprland as the window manager, Neovim as the editor, Kitty as the terminal, Zsh as the shell, and Tmux for terminal multiplexing. Optimized for Arch Linux.

## Prerequisites

Before installing, ensure you have the following:

- Arch Linux with Wayland support
- Git
- Basic build tools (gcc, make, etc.)

### Fonts

Install Nerd Fonts Cascadia:

```sh
sudo pacman -S ttf-cascadia-code-nerd
```

## Installation

1. Clone this repository:

   ```sh
   sudo pacman -S stow
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   stow .
   ```

2. Run the installation and copy files with stow.

3. Install required packages for each component.

## Components

### Shell (Zsh)

Zsh with Oh My Zsh, Powerlevel10k theme, syntax highlighting, autosuggestions, and useful aliases.

**Installation:**

```sh
sudo pacman -S zsh zsh-syntax-highlighting zsh-autosuggestions
yay -S zsh-theme-powerlevel10k-git
```

**Features:**

- Syntax highlighting for commands
- Autosuggestions
- Enhanced aliases (ls -> lsd, cat -> bat)
- FZF integration for fuzzy finding

### Terminal (Kitty)

Fast, feature-rich terminal emulator.

**Installation:**

```sh
sudo pacman -S kitty
```

### Window Manager (Hyprland)

Wayland compositor with custom keybindings, window rules, and theming.

**Installation:**

```sh
sudo pacman -S hyprpaper hyprlock hypridle hyprsunset hyprpicker hyprcursor xdg-desktop-portal-hyprland hyprpolkitagent swaync
```

**Features:**

- Custom keybinds
- Window and workspace rules
- Theming and animations
- Input device configuration
- Autostart applications

### Editor (Neovim)

Custom Neovim configuration with Lua, lazy.nvim plugin manager, LSP support, and various plugins.

**Installation:**

```sh
sudo pacman -S neovim nodejs npm
```

**Plugins include:**

- Treesitter for syntax highlighting
- Telescope for fuzzy finding
- LSP for language server support
- Git integration with gitsigns
- And many more

### Multiplexer (Tmux)

Terminal multiplexer with custom configuration.

**Installation:**

```sh
sudo pacman -S tmux
```

## Usage

After installation, log out and back in or restart your session to apply changes. Your desktop environment should now use Hyprland with all customizations.

- Use Hyprland keybinds for window management
- Launch Kitty terminal
- Use Neovim for editing
- Tmux for multiplexing terminals
- Zsh with enhanced features

## Additional Tools

Install additional tools mentioned in the configs:

- lsd (modern ls replacement): `sudo pacman -S lsd`
- bat (modern cat replacement): `sudo pacman -S bat`
- fzf (fuzzy finder): `sudo pacman -S fzf`
- walker (terminal launcher): `yay -S walker`
  - Requires [elephant](https://github.com/abenz1267/elephant) backend: `yay -S elephant`
  - Dependencies: GTK4, gtk4-layer-shell, protobuf, cairo, poppler-glib
- And others as needed
