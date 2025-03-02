# jtx-nixos hosts configuration

{ modulesPath, ... }:

{

  imports = [ (modulesPath + "/profiles/qemu-quest.nix") ];

  networking = {
    hostName = "virt-nixos";
  };

}
