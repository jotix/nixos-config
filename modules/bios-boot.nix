### uefi-boot Module

{ config, lib, pkgs, ... }:

{
  options.uefi-boot.enable = lib.mkEnableOption "Enable uefi-boot";

  config = lib.mkIf(config.uefi-boot.enable) {

    boot.loader = {
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "auto";
      efi.canTouchEfiVariables = true;
    };

  };
}
