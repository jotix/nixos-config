#!/bin/sh
# 
# Para proceder con la instalacion son necesarias 
# las siguientes particiones formateadas y con las
# etiquetas indicadas:
# -- una particion FAT32, efi(ef00), LABEL=EFI
# -- una particion btrfs, LABEL=btrfs-vol-1
# El presente script crea los subvolumenes para el 
# sistema y los monta en el lugar correspondiente.
#
# Luego de ejecutar el presente script proceder 
# con la instalación de nixos ejecutando:
#
# > sudo nixos-install --flake .#jtx
#

sudo mount LABEL=btrfs-vol-1 /mnt

sudo btrfs subvolume create /mnt/nixos
sudo btrfs subvolume create /mnt/home

sudo umount /mnt

sudo mount LABEL=btrfs-vol-1 /mnt -osubvol=nixos
sudo mkdir -p /mnt/home
sudo mkdir -p /mnt/boot/efi

sudo mount LABEL=btrfs-vol-1 /mnt/home -osubvol=home

sudo mount LABEL=EFI /mnt/boot/efi

