### libvirt Module

{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.libvirt.enable = lib.mkEnableOption "Enable virtualization";

  config = lib.mkIf (config.libvirt.enable) {

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          ovmf = {
            enable = true;
            packages = [ pkgs.OVMFFull.fd ];
          };
          swtpm.enable = true;
        };
      };
      spiceUSBRedirection.enable = true;
    };
    programs.virt-manager = {
      enable = true;
      package = pkgs.virt-manager;
    };
    #virtualisation.tpm.enable = true;

  };
}
