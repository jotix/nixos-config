# jtx-nixos hosts configuration

{ ... }:

{

  networking = {
    hostName = "virt-nixos";
  };

  uefi-boot.enable = false;
  bios-boot.enable = true;

}
