#!/bin/sh
# 
# Para proceder con la instalacion son necesarias 
# las siguientes particiones formateadas y con las
# etiquetas indicadas:
# -- una particion FAT32, efi(ef00), LABEL=JTX-EFI
# -- una particion btrfs, LABEL=jtx-system
# El presente script crea los subvolumenes para el 
# sistema y los monta en el lugar correspondiente.
#
# Luego de ejecutar el presente script proceder 
# con la instalación de nixos ejecutando:
#
# > sudo nixos-install --flake .#jtx
#

sudo mount LABEL=jtx-system /mnt

sudo btrfs subvolume create /mnt/nixos
sudo btrfs subvolume create /mnt/nixos/root
sudo btrfs subvolume create /mnt/nixos/home
sudo btrfs subvolume create /mnt/nextcloud

sudo umount /mnt

sudo mount LABEL=jtx-system /mnt -osubvol=nixos/root
sudo mkdir -p /mnt/home
sudo mkdir -p /mnt/boot/efi

sudo mount LABEL=jtx-system /mnt/home -osubvol=nixos/home

sudo mount LABEL=JTX-EFI /mnt/boot/efi

