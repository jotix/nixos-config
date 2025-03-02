{
  description = "jotix NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      hm-config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "bak";
        home-manager.users.jotix = import ./home-manager/home.nix;
      };
    in
    {
      nixosConfigurations = {
        jtx-nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/jtx-config.nix
            ./config.nix
            ./hardware-config.nix
            home-manager.nixosModules.home-manager
            hm-config
          ];
        };

        ffm-nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/ffm-config.nix
            ./config.nix
            ./hardware-config.nix
            home-manager.nixosModules.home-manager
            hm-config
            {
              home-manager.users.filofem = ./home-manager/ffm-home.nix;
            }
          ];
        };


          virt-nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./hosts/virt-config.nix
              ./config.nix
              ./hardware-config.nix
              home-manager.nixosModules.home-manager
              hm-config
            ];

        };
      };
    };

}
