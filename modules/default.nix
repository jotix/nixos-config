{ lib, ... }:

{
  imports = [
    ./bios-boot.nix
    ./cups/default.nix
    ./gnome.nix
    ./plasma.nix
    ./qmk.nix
    ./steam.nix
    ./syncthing.nix
    ./ttc-price-update.nix
    ./uefi-boot.nix
  ];

  cups.enable = lib.mkDefault true;
  plasma.enable = lib.mkDefault true;
  steam.enable = lib.mkDefault true;
  uefi-boot.enable = lib.mkDefault true;

}
