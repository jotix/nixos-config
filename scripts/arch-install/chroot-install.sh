#!/usr/bin/env bash

### enable parallel downloads in new installation
sed -i -e 's/#ParallelDownloads = 5/ParallelDownloads = 10/g' /etc/pacman.conf

### locale config
ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime
hwclock --systohc
sed -i -e 's/#en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen
sed -i -e 's/#es_AR.UTF-8/es_AR.UTF-8/g' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > etc/locale.conf

### install packages ##########################################################
PACKAGES="
networkmanager ntp
exfatprogs ntfs-3g dosfstools btrfs-progs
efibootmgr amd-ucode
unzip p7zip
base-devel cmake sudo
less man-pages man-db
exa bat fastfetch lsb-release
ttf-jetbrains-mono ttf-jetbrains-mono-nerd 
ttf-ubuntu-font-family ttf-ubuntu-mono-nerd ttf-ubuntu-nerd
git lazygit openssh go
neovim emacs firefox
mesa xf86-video-amdgpu vulkan-radeon
gnome gnome-extra gnome-browser-connector
cups ghostscript system-config-printer
"
pacman -S --noconfirm --needed $PACKAGES

### config the bootloader
bootctl install
echo -e "default  arch.conf
timeout  5
console-mode max
editor   no
" > /boot/loader/loader.conf

echo -e "title   Arch Linux
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options root=LABEL=Arch rootflags=subvol=/@ rootfstype=btrfs rw
" > /boot/loader/entries/arch.conf

echo -e "title   Arch Linux (fallback initramfs)
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux-fallback.img
options root=LABEL=Arch rootflags=subvol=/@ rootfstype=btrfs rw
" > /boot/loader/entries/arch-fallback.conf


### config sudo
sed -i -e 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g' /etc/sudoers

### set the password & users
echo -e "\nSET ROOT PASSWORD\n"
passwd
echo -e "\nSET JOTIX PASSWORD\n"
useradd -m -G wheel -s /bin/bash jotix
passwd jotix
if [[ $HOST == "ffm-arch" ]]; then
    useradd -m -s /bin/bash filofem
    echo -e "\nSET FILOFEM PASSWORD\n"
    passwd filofem
fi

### install & config libvirt
pacman -S --noconfirm --ask=4 libvirt iptables-nft dnsmasq dmidecode virt-manager qemu-full
usermod -a -G libvirt jotix

### enable services
systemctl enable fstrim.timer
systemctl enable gdm
systemctl enable cups.service
systemctl enable NetworkManager
systemctl enable ntpdate
systemctl enable libvirtd.service

### powerline-go
sudo -u jotix go install github.com/justjanne/powerline-go@latest

### printer drivers
pacman -U --noconfirm /root/printer-drivers/*.zst

