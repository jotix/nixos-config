{ lib, ... }:

{

  imports = [
    ./emacs/emacs.nix
    ./gnome-settings.nix
    ./ghostty.nix
    ./helix.nix
    ./kitty.nix
    ./neovim.nix
    ./openttd.nix
    ./zed.nix
  ];

  ### default enable modules

  emacs.enable = lib.mkDefault true;
  openttd.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;
  zed.enable = lib.mkDefault true;
  # helix.enable = lib.mkDefault true;
  gnome-settings.enable = lib.mkDefault true;
  ghostty.enable = lib.mkDefault true;

}
