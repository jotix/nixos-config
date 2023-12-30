# hardware config
{ config, lib, pkgs, modulesPath, ... }:

{
  # KEYBOARD
  services.xserver = {
    layout = "es";
  };

  # HOSTNAME
  networking.hostName = "jtx-nixos";

  # USER
  users.users.filofem = {
    isNormalUser = true;
    description = "FILOfem";
    extraGroups = [ "networkmanager" "libvirtd" ];
  };
}
