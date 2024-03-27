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
        id = "35F4IWI-YEXCQ2O-SBHYPFD-MDDFMFV-FJWAFQT-WLRW2KK-6YWZ2JY-NBECQQO";
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
