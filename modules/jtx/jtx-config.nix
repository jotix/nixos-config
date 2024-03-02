# jtx-nixos configuration

{ config, pkgs, lib, ... }:

{
  networking.hostName = "jtx-nixos";

  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };
  
  ## EXTRA FS
  fileSystems."/mnt/jtx-ssd" = {
    device = "/dev/disk/by-label/jtx-ssd";
    fsType = "btrfs";
    options = [ "subvol=/" ];
  };

  fileSystems."/mnt/jtx-nvme" = {
    device = "/dev/disk/by-label/jtx-nvme";
    fsType = "btrfs";
    options = [ "subvol=/" ];
  };

}
