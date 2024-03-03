# ffm-nixos configuration

{ config, pkgs, lib, ... }:

{
  networking.hostName = "ffm-nixos";
  
  users.users.filofem = {
      isNormalUser = true;
      description = "FILOfem";
      extraGroups = [ "networkmanager" "libvirtd" ];
    };

  services.xserver.xkb = {
    layout = "es";
    #variant = "";
  };
}
