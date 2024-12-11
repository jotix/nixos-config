#!/usr/bin/env bash

set -e

echo
lsblk -o +LABEL
echo 
read -p "In which disk will NixOS be instaled: " DISK
DISK="/dev/$DISK"
if [[ ! -b $DISK ]]; then
    echo "The disk $DISK doesn't exist."
    exit
fi

echo 
read -p "Wich host install (jtx or ffm): " HOST
if [[ $HOST != "jtx" ]] && [[ $HOST != "ffm" ]]; then
    echo "The host $HOST doesn't exists"
    exit
fi
HOST=$HOST-arch

echo 
read -p "The disk $DISK will be complete deleted. Continue? (yes/no): " CONTINUE
if [[ $CONTINUE != "yes" ]]; then
    echo "Aborting installation."
    exit
fi

echo 
read -p "REALLY? (YES/NO): " CONTINUE
if [[ $CONTINUE != "YES" ]]; then
    echo "Aborting installation."
    exit
fi

echo
echo "Installing Arch Linux in $DISK"
echo "Hostname: $HOST"
echo

if [[ $HOSTNAME == "ffm-arch" ]] || [[ $HOSTNAME == "jtx-arch" ]]; then
    echo "Executing in testing mode..."
    exit
fi

### disk configuration ########################################################

# create partition table
sudo parted $DISK mklabel gpt

# make EFI & btrfs partitions
sudo parted --align optimal -- $DISK mkpart ARCH-BOOT fat32 1M 1G
sudo parted --align optimal -- $DISK mkpart Arch btrfs 1G 100%

# set esp flag in EFI partition
sudo parted $DISK set 1 esp on

# make the filesystems
sudo mkfs.vfat -F32 -n ARCH-BOOT /dev/disk/by-partlabel/ARCH-BOOT
sudo mkfs.btrfs -L Arch /dev/disk/by-partlabel/Arch -f

# Subvolumes Layout
# @          /
# @home      /home
# @snapshots /.snapshots
# @log       /var/log
# @cache     /var/cache
# @tmp       /var/tmp

# mount the disk & create the subvolumes
mount LABEL=Arch /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@cache
btrfs subvolume create /mnt/@tmp
umount -R /mnt

# make the directories
mount LABEL=Arch /mnt -osubvol=/@
mkdir -p /mnt/boot
mkdir -p /mnt/home
mkdir -p /mnt/.snapshots
mkdir -p /mnt/var/log
mkdir -p /mnt/var/cache
mkdir -p /mnt/var/tmp
mkdir -p /mnt/mnt/root-partition

# mount ESP part
mount LABEL=ARCH-BOOT /mnt/boot

# mounting btrfs main disk subvolumes
mount LABEL=Arch /mnt/home -osubvol=@home
mount LABEL=Arch /mnt/.snapshots -osubvol=@snapshots
mount LABEL=Arch /mnt/var/log -osubvol=@log
mount LABEL=Arch /mnt/var/cache -osubvol=@cache
mount LABEL=Arch /mnt/var/tmp -osubvol=@tmp
mount LABEL=Arch /mnt/mnt/root-partition -osubvol=/

if [[ -b "/dev/disk/by-label/jtx-ssd" ]]; then
  mkdir -p /mnt/mnt/jtx-ssd
  mount LABEL=jtx-ssd /mnt/mnt/jtx-ssd -osubvol=/
fi

if [[ -b "/dev/disk/by-label/jtx-nvme" ]]; then
  mkdir -p /mnt/mnt/jtx-nvme 
  mount LABEL=jtx-nvme /mnt/mnt/jtx-nvme -osubvol=/
fi

### enable parallel downloads
sed -i -e 's/#ParallelDownloads = 5/ParallelDownloads = 10/g' /etc/pacman.conf

### install base system
pacstrap /mnt base linux linux-firmware

### generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

### network configuration
echo $HOST > /mnt/etc/hostname

### chroot
cp chroot-install.sh /mnt/root
cp -rv printer-drivers /mnt/root
arch-chroot /mnt /root/chroot-install.sh

### unmount & reboot
echo "Installation finished, you can do some final asjustements now or reboot and use the new system:
> umount -R /mnt
> reboot"
