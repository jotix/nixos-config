{ lib, ... }:

{
  
  imports = [
    ./emacs/emacs.nix
    ./kate/kate.nix
    ./neovim.nix
    ./openttd/openttd.nix
    ./helix.nix
    ./kitty.nix
  ];

  ### default enable modules
  emacs.enable = lib.mkDefault true;
  openttd.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;
  
}
