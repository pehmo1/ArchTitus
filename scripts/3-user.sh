#!/usr/bin/env bash
#github-action genshdoc
#
# @file User
# @brief User customizations and AUR package installation.
echo -ne "
--------------------------------------------------------------------------------
███╗   ███╗ █████╗ ██████╗ ██╗███████╗    ██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗
████╗ ████║██╔══██╗██╔══██╗██║██╔════╝    ██║     ██║████╗  ██║██║   ██║╚██╗██╔╝
██╔████╔██║███████║██║  ██║██║███████╗    ██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝ 
██║╚██╔╝██║██╔══██║██║  ██║██║╚════██║    ██║     ██║██║╚██╗██║██║   ██║ ██╔██╗ 
██║ ╚═╝ ██║██║  ██║██████╔╝██║███████║    ███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗
╚═╝     ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝╚══════╝    ╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝

--------------------------------------------------------------------------------
                         Automated Arch Linux Installer
--------------------------------------------------------------------------------
"
echo -ne "
-------------------------------------------------------------------------
                               Installing yay
-------------------------------------------------------------------------
"
source $HOME/ArchTitus/configs/setup.conf

# Install yay
git clone https://aur.archlinux.org/yay.git /home/$USERNAME/yay
cd /home/$USERNAME/yay
makepkg --noconfirm --needed -si
cd
rm -rf /home/$USERNAME/yay

echo -ne "
-------------------------------------------------------------------------
                        Installing main packages  
-------------------------------------------------------------------------
"

# Install packages
git clone https://github.com/pehmo1/config.git /home/$USERNAME/config
yay -S --noconfirm --needed - < /home/$USERNAME/config/packages.txt
rm -rf /home/$USERNAME/config

echo -ne "
-------------------------------------------------------------------------
                        Installing other packages  
-------------------------------------------------------------------------
"

# Install ohmyzsh and it's themes / plugins
sh -c "CHSH=no RUNZSH=no KEEP_ZSHRC=yes $(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use

# dmenu
mkdir -p /home/$USERNAME/Downloads/packages/
git clone https://github.com/pehmo1/dmenu.git /home/$USERNAME/Downloads/dmenu
cd /home/$USERNAME/Downloads/dmenu
sudo make clean install

# configs
git clone https://github.com/pehmo1/config.git /home/$USERNAME/Downloads/config
/home/$USERNAME/Downloads/config/paste.sh

export PATH=$PATH:~/.local/bin

# pip installs
pip install pillow

# configure git
git config --global user.name "pehmo1"
git config --global user.email "<>"
git config --global credential.helper store

# install vim.plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# make sure bspwmrc is executable
chmod +x /home/$USERNAME/.config/bspwm/bspwmrc

echo -ne "
-------------------------------------------------------------------------
                    SYSTEM READY FOR 3-post-setup.sh
-------------------------------------------------------------------------
"
exit
