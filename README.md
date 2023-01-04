This is an automated Arch Linux installer with my config.

## How to install

### Option 1:
Download the official [Arch Linux ISO file](https://archlinux.org/download) and burn it to a USB drive with [Rufus](https://rufus.ie/en/) on Windows or "dd" command on Linux.

Boot from the USB and type in the following commands:

```
pacman-key --init
pacman-key --populate archlinux
pacman -Syu --noconfirm
pacman -Sy --noconfirm git
git clone https://github.com/pehmo1/ArchTitus.git
./ArchTitus/archtitus.sh
```

### Option 2:
Generate an .iso with all the necessary files alread on it with [Archiso](https://wiki.archlinux.org/title/Archiso) and my config files for it.

See how to generate the .iso [here](https://github.com/pehmo1/archimg).

Burn the .iso to a USB with [Rufus](https://rufus.ie/en/) on Windows or "dd" command on Linux.

Boot from the USB and run ```./ArchTitus/archtitus.sh```