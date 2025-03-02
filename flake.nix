{
  description = "jotix NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }: {
    
    nixosConfigurations = {
      jtx-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/jtx-config.nix
          ./config.nix
          ./hardware-config.nix
        ];
      };

      ffm-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/ffm-config.nix
          ./config.nix
          ./hardware-config.nix
        ];
      };

      virt-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/virt-config.nix
          ./config.nix
          ./hardware-config.nix
        ];
      };
    };
  };

}
