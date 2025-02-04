#! /bin/bash

set -o pipefail

cd

read -p "There are 2 package managers that can be used for installation.
Type the corresponding number:
    1) APT      2) pacman

Enter a selection (default=1): " distro

git clone https://github.com/cfung89/.dotfiles.git $HOME/.config

if [[ $distro == 1 || $distro == "" ]] ; then
    echo "Installing packages with APT"
    apt update && apt upgrade
    apt install -y --no-install-recommends \
        git \
        fzf \
        tmux

    echo "Installing neovim from source"
    apt-get install ninja-build gettext cmake curl build-essential
    git clone https://github.com/neovim/neovim
    cd neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb || make install   # if this doesn't work, try `sudo make install`

elif [[ $distro -eq 2 ]]; then
    echo "Installing packages with pacman"
    pacman -S --noconfirm \
        git \
        fzf \
        tmux \
        neovim \
        python3
else
    echo "Error: Invalid input"
fi

echo "Installing tmux plugins"
cd $HOME/.config/tmux
mkdir plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm
git clone -b v2.1.2 https://github.com/catppuccin/tmux.git $HOME/.config/tmux/plugins/tmux
echo "You can now reload tmux plugins with Prefix + Shift + I
"

cp ~/.config/bashrc ~/.bashrc
cp ~/.config/profile ~/.bash_profile
# cp ~/.config/X11/xinitrc ~/.xinitrc

echo "Installation complete"
