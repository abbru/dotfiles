# Dotfiles

This repository contains my personal dotfiles configuration for a customized Linux desktop environment using Hyprland as the window manager, Neovim as the editor, Kitty as the terminal, Zsh as the shell, and Tmux for terminal multiplexing. Optimized for Arch Linux.

## Prerequisites

Before installing, ensure you have the following:

- Arch Linux with Wayland support
- Git
- Basic build tools (gcc, make, etc.)

### Fonts

Install Nerd Fonts JetBrainsMono:

```sh
cd /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
```

## Installation

1. Clone this repository:

   ```sh
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Run the installation script (if available) or manually copy/symlink the files.

3. Install required packages for each component.

## Components

### Shell (Zsh)

Zsh with Oh My Zsh, Powerlevel10k theme, syntax highlighting, autosuggestions, and useful aliases.

**Installation:**

```sh
sudo pacman -S zsh zsh-syntax-highlighting zsh-autosuggestions
# Install Oh My Zsh (follow their instructions)
# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
# Configure with p10k configure
```

**Features:**

- Syntax highlighting for commands
- Autosuggestions
- Enhanced aliases (ls -> lsd, cat -> bat)
- FZF integration for fuzzy finding

**Configuration:** Copy `.zshrc` to `~/.zshrc`

### Terminal (Kitty)

Fast, feature-rich terminal emulator.

**Installation:**

```sh
sudo pacman -S kitty
```

**Configuration:** Copy `kitty/` to `~/.config/kitty/`

### Window Manager (Hyprland)

Wayland compositor with custom keybindings, window rules, and theming.

**Installation:**

```sh
sudo pacman -S hyprpaper hyprlock hypridle hyprsunset hyprpicker hyprcursor xdg-desktop-portal-hyprland hyprpolkitagent
```

**Configuration:** Copy `hypr/` to `~/.config/hypr/`

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

**Configuration:** Copy `nvim/` to `~/.config/nvim/`

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

**Configuration:** Copy `.tmux.conf` to `~/.tmux.conf`

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
- And others as needed
