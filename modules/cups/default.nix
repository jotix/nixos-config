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

    hardware.printers = {
      ensurePrinters = [
        {
          name = "XP-58";
          # location = "Home";
          deviceUri = "usb://Printer-58/USB%20Printing%20Support?serial=?";
          model = "xprinterpos/POS-58.ppd";
          #ppdOptions.PageSize = "A4";
        }
        {
          name = "Brother_HL-1212W";
          location = "FILOfem";
          deviceUri = "ipp://192.168.0.7/ipp/port1";
          model = "drv:///brlaser.drv/br1200.ppd";
          ppdOptions.PageSize = "A4";
        }
      ];
      ensureDefaultPrinter = "XP-58";
    };

  };
}
