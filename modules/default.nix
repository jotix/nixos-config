{ config, lib, ... }:

let
  hostname = config.networking.hostName;
in

{
  imports = [
    ./cups/default.nix
    ./fish.nix
    ./gnome.nix
    ./plasma.nix
    ./qmk.nix
    ./steam.nix
    ./libvirt.nix
  ];

  cups.enable = lib.mkDefault true;
  fish.enable = lib.mkDefault true;
  gnome.enable = lib.mkDefault true;
  # plasma.enable = lib.mkDefault true;
  qmk.enable = lib.mkDefault true;
  steam.enable = lib.mkDefault true;
  libvirt.enable = lib.mkDefault (hostname != "virt-nixos");

}
