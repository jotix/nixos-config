# Jotix's NixOs configuration

# REQUISITOS: 
Para proceder con la instalacion son necesarias 
las siguientes particiones formateadas y con las
etiquetas indicadas:
-- una particion FAT32, efi(ef00), LABEL=JTX-EFI
-- una particion btrfs, LABEL=jtx-system
El presente script crea los subvolumenes para el 
sistema y los monta en el lugar correspondiente.

### update flake 

nix flake update --extra-experimental-features 'nix-command flakes'

### install new system

sudo nixos-install --flake .#[hostname]

### copy nixos-config folder to the new installation
# or run the scripts/cp-nixos-config.sh script in this folder

echo "Changing nixos-config origin repo"
git remote remove origin
git remote add origin git@github.com:jotix/nixos-config.git
sudo cp -rv ~/nixos-config /mnt/home/jotix/
sudo nixos-enter --command 'chown -R jotix /home/jotix/nixos-config'

### set jotix's password

echo "SET JOTIX'S PASSWORD"
sudo nixos-enter --command 'passwd jotix'

