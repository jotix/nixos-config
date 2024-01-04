
{
  description = "jotix NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {

      jtx-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common/configuration.nix
          #./modules/common/system-packages.nix
          #./modules/common/hardware-config.nix
          #./modules/common/home-config.nix
          #./modules/jtx/jtx-config.nix
          #./modules/jtx/extra-filesystems.nix
          #./modules/emacs/emacs.nix
          #./modules/nvim/nvim.nix
          { networking.hostname = "jtx-nixos"; }
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

      ffm-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common/configuration.nix
          #./modules/common/system-packages.nix
          #./modules/common/hardware-config.nix
          #./modules/common/home-config.nix
          #./modules/ffm/ffm-config.nix
          #./modules/emacs/emacs.nix
          #./modules/nvim/nvim.nix
          { networking.hostname = "ffm-nixos"; }
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

    };
  };
}
