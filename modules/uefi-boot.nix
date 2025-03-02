### bios-boot Module

{ config, lib, pkgs, ... }:

{
  options.bios-boot.enable = lib.mkEnableOption "Enable bios-boot";

  config = lib.mkIf(config.bios-boot.enable) {

    boot.loader = {
      grub.enable = true;
      grub.device = /dev/vda;
    };

  };
}
