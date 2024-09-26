This is an automated installer that installs Arch Linux with my config.

## How to use

Download the official [Arch Linux ISO file](https://archlinux.org/download) and burn it to a USB drive with [Rufus](https://rufus.ie/en/) on Windows or "dd" command on Linux.

Boot from the USB, get a network connection. Ethernet works by itself, for wifi use [iwctl](https://wiki.archlinux.org/title/Iwd).

Then type in the following commands:

```
pacman -Sy --noconfirm git
git clone https://github.com/pehmo1/ArchTitus.git
./ArchTitus/archtitus.sh
```

### After install
Run :PlugInstall in neovim

Set up / log in to programs