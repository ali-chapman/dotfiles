#! /usr/bin/env fish
# Assumes that tmux, fish, and alacritty are all installed

echo "CONFIGURING MACHINE"

# Alacritty config
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
rm ~/.config/alacritty/alacritty.yml
ln -s ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
echo "Configured Alacritty"

# Fish
mkdir -p ~/.config/fish
rm ~/.config/fish/config.fish
ln -s ~/dotfiles/config.fish ~/.config/fish/config.fish

# LunarVim
rm -rf ~/.config/lvim/
curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh > lvim_installer.sh
chmod +x lvim_installer.sh
./lvim_installer.sh -y
rm ~/.config/lvim/config.lua
ln -s ~/dotfiles/lvim.lua  ~/.config/lvim/config.lua
echo "Configured LunarVim"

# Tmux
rm ~/.tmux.conf
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
echo "Configued Tmux.\n RUN <prefix>+I OTHERWISE TMUX PLUGINS WILL NOT WORK"
