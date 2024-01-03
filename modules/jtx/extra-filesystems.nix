# extra filesystems

{ config, lib, pkgs, modulesPath, ... }:

{
  ## EXTRA FS
  fileSystems."/mnt/btrfs-vol-2" = {
    device = "/dev/disk/by-label/btrfs-vol-2";
    fsType = "btrfs";
    options = [ "subvol=/" ];
  };

  fileSystems."/mnt/btrfs-vol-3" = {
    device = "/dev/disk/by-label/btrfs-vol-3";
    fsType = "btrfs";
    options = [ "subvol=/" ];
  };
}
