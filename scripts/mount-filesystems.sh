#!/bin/sh

### mount filesystems

sudo mount LABEL=jtx-system /mnt

sudo btrfs subvolume create /mnt/nixos
sudo btrfs subvolume create /mnt/nixos/root
sudo btrfs subvolume create /mnt/nixos/home

sudo umount /mnt

sudo mount LABEL=jtx-system /mnt -osubvol=nixos/root
sudo mkdir -p /mnt/home
sudo mkdir -p /mnt/boot/efi

sudo mount LABEL=jtx-system /mnt/home -osubvol=nixos/home

sudo mount LABEL=JTX-EFI /mnt/boot/efi

