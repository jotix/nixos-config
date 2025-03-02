#!/usr/bin/env bash

DISK=/dev/vda
PART=/dev/vda1
HOST=virt-nixos

sudo umount -R /mnt

# make a new GPT partition table
sudo parted $DISK mklabel msdos

# make btrfs partition
sudo parted $DISK mkpart primary btrfs 1MiB 100%

# make the filesystems
sudo mkfs.btrfs -L NixOS $PART -f

# mount the disk & create the subvolumes
sudo mount LABEL=NixOS /mnt
sudo btrfs subvolume create /mnt/@
sudo btrfs subvolume create /mnt/@nix
sudo btrfs subvolume create /mnt/@home
sudo umount -R /mnt

# make the directories
sudo mount LABEL=NixOS /mnt -osubvol=/@
sudo mkdir -p /mnt/home
sudo mkdir -p /mnt/nix

# mount all in the right place
sudo mount LABEL=NixOS /mnt/home -osubvol=/@home
sudo mount LABEL=NixOS /mnt/nix -osubvol=/@nix

# Install new system
sudo nixos-install --flake "github:jotix/nixos-config/#$HOST"

# set jotix's password
echo "ENTER JOTIX PASSWORD"
sudo nixos-enter --command 'passwd jotix'

# set filofem password
if [[ $HOST == "ffm-nixos" ]]; then
    echo "ENTER FILOFEM PASSWORD"
    sudo nixos-enter --command  'passwd filofem'
fi
