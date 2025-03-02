# jtx-nixos hosts configuration

{ modulesPath, ... }:

{

  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  networking = {
    hostName = "virt-nixos";
  };

  uefi-boot.enable = false;
  bios-boot.enable = true;

}
