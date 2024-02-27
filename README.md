# Jotix's NixOs configuration

### Requirements 

To proced with the installation are required
the following partitions
-- FAT32, efi(ef00), LABEL=JTX-EFI
-- btrfs, LABEL=jtx-system

### Mounting the FS

The script ./scripts/mount-filesystems make the
subvolumes in the btrfs filesystem and mount all the
partitions/subvolumes in the correct place.

### Update flake 

Optional: to update the flake, run the following command:

$ nix flake update --extra-experimental-features 'nix-command flakes'

### Install the new system

$ sudo nixos-install --flake .#[hostname]

### copy nixos-config folder to the new installation

If changes are made any file of this repo, copy it to
the new installation, if you don't want to loose
the changes, run the following script:

$ ./scripts/cp-nixos-config.sh

### set jotix's password

Set the password for the new installation,
run the script:

$ ./scripts/set-jotix-password.sh

