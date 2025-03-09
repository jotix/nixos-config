### virt-host Module

{ config, lib, ... }:

{
  options.virt-host.enable = lib.mkEnableOption "Enable virt-host";

  config = lib.mkIf (config.virt-host.enable) {

    libvirt.enable = false;

  };
}
