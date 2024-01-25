# hardware config
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/jtx-system";
    fsType = "btrfs";
    options = [ "subvol=nixos/root" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/jtx-system";
    fsType = "btrfs";
    options = [ "subvol=nixos/home" ];
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-label/JTX-EFI";
    fsType = "vfat";
  };

  fileSystems."/mnt/jtx-system" = {
    device = "/dev/disk/by-label/jtx-system";
    fsType = "btrfs";
    options = [ "subvol=/" ];
  };

  fileSystems."/mnt/Ventoy" = {
    device = "/dev/disk/by-label/Ventoy";
    fsType = "exfat";
    options = [ "user" "users" ];
  };

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 4096;
  } ];

  ## EXTRA FS
  #fileSystems."/mnt/jtx-ssd" = {
  #  device = "/dev/disk/by-label/jtx-ssd";
  #  fsType = "btrfs";
  #  options = [ "subvol=/" ];
  #};

  #fileSystems."/mnt/jtx-nvme" = {
  #  device = "/dev/disk/by-label/jtx-nvme";
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
