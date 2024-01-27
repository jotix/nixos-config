#!/bin/sh
#
# invoque ieste script con el nombre del sistema
# a instalar: jtx-nixos or ffm-nixos
#
# REQUISITOS: 
# Para proceder con la instalacion son necesarias 
# las siguientes particiones formateadas y con las
# etiquetas indicadas:
# -- una particion FAT32, efi(ef00), LABEL=JTX-EFI
# -- una particion btrfs, LABEL=jtx-system
# El presente script crea los subvolumenes para el 
# sistema y los monta en el lugar correspondiente.
#

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

### update flake 

nix flake update --extra-experimental-features 'nix-command flakes'

### install new system

sudo nixos-install --flake .#$@

### copy nixos-config folder to the new installation

echo "Changing nixos-config origin repo"
git remote remove origin
git remote add origin git@github.com:jotix/nixos-config.git
sudo cp -rv ../nixos-config /mnt/home/jotix/
sudo nixos-enter --command 'chown -R jotix /home/jotix/nixos-config'

### set jotix's password

echo "SET JOTIX'S PASSWORD"
sudo nixos-enter --command 'passwd jotix'

