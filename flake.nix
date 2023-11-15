
{
  description = "jotix NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {

      jtx-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
          # { networking.hostname = "jtx-nixos"; }
        ];
      };

#      ffm-nixos = nixpkgs.lib.nixosSystem {
#        system = "x86_64-linux";
#        modules = [
#          ./configuration.nix
#          home-manager.nixosModules.home-manager {
#            home-manager.useGlobalPkgs = true;
#            home-manager.useUserPackages = true;
#          }
#          # { networking.hostname = "ffm-nixos"; }
#        ];
#      };

    };
  };
}
