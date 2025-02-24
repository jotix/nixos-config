### Plasma Module

{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.plasma.enable = lib.mkEnableOption "Enable KDE Plasma Desktop Environment";

  config = lib.mkIf (config.plasma.enable) {

    services.xserver.enable = true;

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
    };

    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = with pkgs; [
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

    ### TODO
    ### ENABLE THIS ONLY IN jtx-nixos HOST
    # environment.shellAliases = {
    #   f1tv = ''export $(dbus-launch); kwin_wayland "firefox -P" &'';
    #   "2monitors" =
    #     "kscreen-doctor output.DP-1.enable output.DP-1.position.-1920,450 output.HDMI-A-1.position.0,0";
    #   "1monitor" = "kscreen-doctor output.DP-1.disable output.HDMI-A-1.position.0,0";
    # };
    #
    # ### sddm refresh rate
    # services.xserver.displayManager.setupCommands = ''
    #   kscreen-doctor output.HDMI-A-1.position.0,0 output.HDMI-A-1.mode.17
    # '';

  };
}
