# hardware config
{ config, lib, pkgs, modulesPath, ... }:

{
  # HOSTNAME

  networking.hostName = "jtx-nixos";
  
  ## HARDWARE

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

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
