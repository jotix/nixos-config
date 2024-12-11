### Plasma Module

{ config, lib, pkgs, ... }:

{
  options.plasma.enable = lib.mkEnableOption "Enable KDE Plasma Desktop Environment";

  config = lib.mkIf(config.plasma.enable) {

    home-manager.users.jotix.kitty.enable = lib.mkDefault true;

    services.xserver.enable = true;

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
    };

    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = with pkgs; [
      kitty
      kdePackages.kate
      kdePackages.kcalc
      kdePackages.plasma-browser-integration
    ];
    # ++ kdePackages.sources
    #   |> builtins.attrNames
    #   |> builtins.map (n: kdePackages.${n})
    #   |> builtins.filter (pkg: !pkg.meta.broken)
    # ];

    # lib.pipe kdePackages.sources [
    #   builtins.attrNames
    #   (builtins.map (n: kdePackages.${n}))
    #   (builtins.filter (pkg: !pkg.meta.broken))
    # ]

    programs.chromium.plasmaBrowserIntegrationPackage = pkgs.kdePackages.plasma-browser-integration;

  };
}
