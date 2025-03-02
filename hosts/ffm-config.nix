# ffm-nixos configuration

{ pkgs, ... }:

{

  qmk.enable = true;

  networking.hostName = "ffm-nixos";

  environment.shellAliases.camara = "mpv rtsp://jujodeve:SuperJoti3275@192.168.0.6/stream1 --profile=low-latency --no-audio";

  users.users.filofem = {
    isNormalUser = true;
    description = "FILOfem";
    extraGroups = [
      "networkmanager"
      "libvirtd"
    ];
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Brother_HL-1212W";
        location = "FILOfem";
        deviceUri = "ipp://192.168.0.7/ipp/port1";
        model = "drv:///brlaser.drv/br1200.ppd";
        ppdOptions.PageSize = "A4";
      }
    ];
  };

  ### Ventoy
  fileSystems."/mnt/Ventoy" = {
    device = "/dev/disk/by-label/Ventoy";
    fsType = "exfat";
    options = [ "defaults" ];
  };

}
