# Jotix's NixOs configuration

## Requirements

To proced with the installation the following 
partitions are required:
* FAT32, efi(ef00), LABEL=JTX-EFI
* btrfs, LABEL=jtx-system

## Mounting the filesystems

To mount the filesystems/volumes in the
correct place run the script:

    script ./scripts/mount-filesystems

## Update flake 

Optional: to update the flake, run the following command:

    $ nix flake update --extra-experimental-features 'nix-command flakes'

## Install the new system

To install the new system run the following command:

    $ sudo nixos-install --flake .#[hostname]

## copy nixos-config folder to the new installation

If changes are made in any file of this repo, copy it to
the new installation if you don't want to loose
the changes, run the following script:

    $ ./scripts/cp-nixos-config.sh

## set jotix's password

Set the password for the new installation,
run the script:

    $ ./scripts/set-jotix-password.sh

