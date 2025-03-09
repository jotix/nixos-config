### jtx-host Module

{ config, lib, ... }:

{
  options.jtx-host.enable = lib.mkEnableOption "Enable jtx-host";

  config = lib.mkIf(config.jtx-host.enable) {

    ### jtx-nvme
    fileSystems."/mnt/jtx-nvme" = {
      device = "/dev/disk/by-label/jtx-nvme";
      fsType = "btrfs";
      options = [ "subvol=/" ];
    };

    ### jtx-ssd
    fileSystems."/mnt/jtx-ssd" = {
      device = "/dev/disk/by-label/jtx-ssd";
      fsType = "btrfs";
      options = [ "subvol=/" ];
    };

    ### bluetooth
    hardware.bluetooth.enable = true;

    boot.kernelParams = [
      "video=HDMI-A-1:3840x2160@60"
    ];

    ### Ventoy
    fileSystems."/mnt/Ventoy" = {
      device = "/dev/disk/by-label/Ventoy";
      fsType = "exfat";
      options = [ "defaults" ];
    };

    
  };
}
