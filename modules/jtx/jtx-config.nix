# hardware config
{ config, lib, pkgs, modulesPath, ... }:

{

  # KEYBOARD
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";  
  };

  # HOSTNAME
  networking.hostName = "jtx-nixos";
  
}
