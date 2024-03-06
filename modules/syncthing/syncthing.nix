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
        id = "THT4UXZ-B2MWUBD-U2VWBDV-CL3TB3D-LBMUNSV-CHVXRZO-YXSRNDE-CG3WWQZ";
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
