# share configuration

{ config, pkgs, ... }:

{
  # Syncthing
  services.syncthing = {
    enable = true;
    user = "jotix";
    dataDir = "/home/jotix";
    configDir = "/home/jotix/.config/syncthing";
    devices."motorola_edge_30".id = "ZUMZLZC-AOEBXYB-UWHAYLK-UWCGUQ6-PFBLUGR-OIBHVRW-Y7JYEQT-XZA62QM";
    folders = {
      "Documents" = {
        path = "/home/jotix/Documents";
        devices = [ "motorola_edge_30" ];
      };
      "Pictures" = {
        path = "/home/jotix/Pictures";
        devices = [ "motorola_edge_30" ];
      };
    };
  };
}
