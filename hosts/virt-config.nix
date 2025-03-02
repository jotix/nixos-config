# jtx-nixos hosts configuration

{ modulesPath, ... }:

{

  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  networking = {
    hostName = "virt-nixos";
  };

}
