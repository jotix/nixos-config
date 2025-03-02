# jtx-nixos hosts configuration

{ ... }:

{

  networking = {
    hostName = "virt-nixos";
  };

  bios-boot.enable = false;
  uefi.enable = true;

}
