{ lib, ... }:

{
  imports = [
    ./cups/default.nix
    ./qmk.nix
    ./steam.nix
    ./ttc-price-update.nix
  ];

  cups.enable = lib.mkDefault true;
  steam.enable = lib.mkDefault true;

}
