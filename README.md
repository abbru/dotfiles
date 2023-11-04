# DotFiles

There are the files I use for kitty terminal with zsh and steps I followed to do it

#### Fonts NerdFonts JetBrainsMono
```sh
cd /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip 
```

## Step 1 
### Install kitty terminal

```sh
sudo apt-get install kitty
```

## Step 2
### Config zsh
```sh
echo $SHELL
sudo apt-get install zsh
usermod --shell /usr/bin/zsh :user:
sudo su 
usermod --shell /usr/bin/zsh root
```

## Step 3
### Copy my dotfiles
```sh
cp ./kitty /home/:user:/.config/
cp .zshrc /home/:user:/
cp .p10k.zsh /home/:user:/
sudo su 
ln -s -f /home/:user:/.zshrc /root/.zshrc
```

## Step 4
### Pluyings Missing
Pluyings for change colors on commands, autosuggestions and if you touch esc esc put sudo on your line. Replace cat for barcat and ls for lsd (ls, la, ll, lla, l). Remove files from disk rmk file.

```sh
sudo apt install zsh-syntax-highlighting zsh-autosuggestions
locate zsh-syntax-highlighting
locate zsh-autosuggestions
vim .zshrc //replace value from locate 
cd /usr/share/
sudo su 
mkdir zsh-sudo 
chown user:user zsh-sudo/
exit
cd /user/share/zsh-sudo/
wget https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/sudo/sudo.plugin.zsh
sudo apt-get install lsd bat batcat
sudo apt-get scrub
```

## Step 5
### Powerlevel10k
[powerlevel10k](https://github.com/romkatv/powerlevel10k)
```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
zsh 
yes, yes, yes, 3, 1, 1, 1, 1, 4, 1, 2, 2, 2, yes, yes
cp .p10k.zsh /home/:user:/
sudo su
cd
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
p10k configure
yes, yes, yes, 3, 1, 1, 1, 1, 4, 1, 2, 2, 2, yes, yes, yes
cp .p10k.zsh /home/:user:/
cp .p10k.zsh /root/
```

## Step 6
### fzf
[fzf](https://github.com/junegunn/fzf)
```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## Step 7
### NeoVim NVchad
Remember close after install
[nvchad](https://nvchad.com/docs/quickstart/install)
```sh
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
nvim ./
:NvimTreeToggle
sudo su
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
```