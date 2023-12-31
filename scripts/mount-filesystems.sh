#!/bin/sh
# 
# Para proceder con la instalacion son necesarias 
# las siguientes particiones formateadas y con las
# etiquetas indicadas:
# -- una particion FAT32, efi(ef00), LABEL=EFI-NIX
# -- una particion btrfs, LABEL=NixOS
# El presente script crea los subvolumenes para el 
# sistema y los monta en el lugar correspondiente.
#
# Luego de ejecutar el presente script proceder 
# con la instalación de nixos ejecutando:
#
# > sudo nixos-install --flake .#jtx
#

sudo mount LABEL=NixOS /mnt

sudo btrfs subvolume create /mnt/nixos
sudo btrfs subvolume create /mnt/nixos/root
sudo btrfs subvolume create /mnt/nixos/home

sudo umount /mnt

sudo mount LABEL=NixOS /mnt -osubvol=nixos/root
sudo mkdir -p /mnt/home
sudo mkdir -p /mnt/boot/efi

sudo mount LABEL=NixOS /mnt/home -osubvol=nixos/home

sudo mount LABEL=EFI-NIXOS /mnt/boot/efi

