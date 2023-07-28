#!/bin/bash
# Remount live system to have room to write logs etc.
mount -o remount,size=2G /run/archiso/cowspace

# Make config directory if doesn't exist
mkdir /mnt &>/dev/null # Hiding error message if any

# Find the name of the folder the scripts are in
set -a
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SCRIPTS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/scripts
CONFIGS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/configs
set +a
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
    ( bash $SCRIPT_DIR/scripts/startup.sh )|& tee startup.log
      source $CONFIGS_DIR/setup.conf
    ( bash $SCRIPT_DIR/scripts/0-preinstall.sh )|& tee 0-preinstall.log
    ( arch-chroot /mnt $HOME/ArchTitus/scripts/1-setup.sh )|& tee 1-setup.log
    ( arch-chroot /mnt /usr/bin/runuser -u $USERNAME -- /home/$USERNAME/ArchTitus/scripts/2-user.sh )|& tee 2-user.log
    ( arch-chroot /mnt $HOME/ArchTitus/scripts/3-post-setup.sh )|& tee 3-post-setup.log
    cp -v *.log /mnt/home/$USERNAME

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
                Done - Please Eject Install Media and Reboot
"
