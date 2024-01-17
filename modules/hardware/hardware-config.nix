# hardware config
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/NixOS";
    fsType = "btrfs";
    options = [ "subvol=nixos/root" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/NixOS";
    fsType = "btrfs";
    options = [ "subvol=nixos/home" ];
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-label/EFI-NIXOS";
    fsType = "vfat";
  };

  fileSystems."/mnt/NixOS" = {
    device = "/dev/disk/by-label/NixOS";
    fsType = "btrfs";
    options = [ "subvol=/" ];
  };

  #fileSystems."/mnt/Ventoy" = {
  #  device = "/dev/disk/by-label/Ventoy";
  #  fsType = "ntfs";
  #  #options = [ "user" "users" ];
  #};

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 4096;
  } ];

  ## EXTRA FS
  #fileSystems."/mnt/btrfs-vol-2" = {
  #  device = "/dev/disk/by-label/btrfs-vol-2";
  #  fsType = "btrfs";
  #  options = [ "subvol=/" ];
  #};

  #fileSystems."/mnt/btrfs-vol-3" = {
  #  device = "/dev/disk/by-label/btrfs-vol-3";
  #  fsType = "btrfs";
  #  options = [ "subvol=/" ];
  #};

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
