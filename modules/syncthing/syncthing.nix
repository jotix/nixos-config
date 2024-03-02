# share configuration

{ config, pkgs, ... }:

{
  # Syncthing
  services.syncthing = {
    enable = true;
    user = "jotix";
    dataDir = "/home/jotix";
    configDir = "/home/jotix/.config/syncthing";
    settings = {
      devices."motorola_edge_30" = { 
        id = "KWDHXIQ-EVFQOCM-2HCMAQE-47OZU6F-BHSRHTR-OHJMGPB-SKODLGX-WIVFJQR";
        autoAcceptFolders = true;
      };
      folders = {
        "Documents" = {
          path = "/home/jotix/Documents";
          devices = [ "motorola_edge_30" ];
        };
        "Pictures" = {
          path = "/home/jotix/Pictures";
          devices = [ "motorola_edge_30" ];
        };
        "Camera" = {
          path = "/home/jotix/Camera";
          devices = [ "motorola_edge_30" ];
        };
      };

    };
  };
}
