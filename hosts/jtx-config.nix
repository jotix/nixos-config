# jtx-nixos hosts configuration

{ ... }:

{
  ### options
  qmk.enable = true;

  networking = {
    hostName = "jtx-nixos";
  };

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

  ### sddm refresh rate
  # services.xserver.displayManager.setupCommands = ''
  #  kscreen-doctor output.HDMI-A-1.position.0,0 output.HDMI-A-1.mode.17
  #  xrandr --output HDMI-A-1 --mode 3840x2160 --rate 60
  # '';

  ### Ventoy
  fileSystems."/mnt/Ventoy" = {
    device = "/dev/disk/by-label/Ventoy";
    fsType = "exfat";
    options = [ "defaults" ];
  };

}
