# share configuration

{ config, pkgs, lib, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
  };
  services.desktopManager.plasma6.enable = true;
}
