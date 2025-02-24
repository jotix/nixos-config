{ lib, ... }:

{
  imports = [
    ./cups/default.nix
    ./gnome.nix
    ./plasma.nix
    ./qmk.nix
    ./steam.nix
    ./syncthing.nix
    ./ttc-price-update.nix
  ];

  cups.enable = lib.mkDefault true;
  plasma.enable = lib.mkDefault true;
  steam.enable = lib.mkDefault true;

}
