### Cups Module

{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.cups.enable = lib.mkEnableOption "Enable Cups Printing Service";

  config = lib.mkIf (config.cups.enable) {

    services = {
      printing = {
        enable = true;
        drivers = [
          pkgs.brlaser
          pkgs.cups-filters
          (pkgs.callPackage ./cups-hprtpos.nix { })
          (pkgs.callPackage ./cups-xprinterpos.nix { })
        ];
      };
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}
