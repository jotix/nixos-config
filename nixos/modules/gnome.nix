### Gnome Module

{ config, lib, pkgs, ... }:

{
  options.gnome.enable = lib.mkEnableOption "Enable Gnome Desktop Environment";

  config = lib.mkIf(config.gnome.enable) {

    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnomeExtensions.tiling-assistant
      gnomeExtensions.dash-to-dock
    ];

  };
}
