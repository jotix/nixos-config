{ config, lib, ... }:

let
  hostname = config.networking.hostName;
in

{
  imports = [
    ./cups/default.nix
    ./ffm-host.nix
    ./gnome.nix
    ./jtx-host.nix
    ./plasma.nix
    ./qmk.nix
    ./steam.nix
    ./libvirt.nix
    ./virt-host.nix
  ];

  cups.enable = lib.mkDefault true;
  # gnome.enable = lib.mkDefault true;
  plasma.enable = lib.mkDefault true;
  qmk.enable = lib.mkDefault true;
  steam.enable = lib.mkDefault true;
  libvirt.enable = lib.mkDefault true;

  # hosts modules 
  ffm-host.enable = lib.mkDefault (hostname == "ffm-nixos");
  jtx-host.enable = lib.mkDefault (hostname == "jtx-nixos");
  virt-host.enable = lib.mkDefault (hostname == "virt-nixos");
  
}
