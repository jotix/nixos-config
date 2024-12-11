# jtx-nixos hosts configuration

{ ... }:
let
  f1tv_script = ''
  #!/usr/bin/env bash
  export $(dbus-launch); kwin_wayland "firefox -P" &
  '';
in
{
  ### options
  qmk.enable = true;

  networking = {
    hostName = "jtx-nixos";
  };
  
  environment.shellAliases.f1tv = f1tv_script;
  
  ### jtx-nvme
  fileSystems."/mnt/jtx-nvme" = {
    device = "/dev/disk/by-label/jtx-nvme";
    fsType = "btrfs";
    options = [ "subvol=/" ];
  };

  ### flatpak
  # services.flatpak.enable = false;

  ### bluetooth
  hardware.bluetooth.enable = true;
}
