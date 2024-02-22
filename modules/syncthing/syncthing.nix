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
      devices."motorola_edge_30".id = "2F3BMQM-NK4MVOE-PY4IZWY-FEDBZVZ-BEVXJCH-5LRNBZO-352L3LH-H3HSRAW";
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
