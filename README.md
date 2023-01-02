This is an automated Arch Linux install with my config.

# How to install

Download the Arch Linux ISO file from <https://archlinux.org/download> and burn it to a USB drive with [Rufus](https://rufus.ie/en/) (or "dd" command on linux).

Boot from the USB, type in the following commands:

```
pacman-key --init
pacman-key --populate archlinux
pacman -Syu --noconfirm
pacman -Sy --noconfirm git
git clone https://github.com/pehmo1/ArchTitus.git
cd ArchTitus
./archtitus.sh
```