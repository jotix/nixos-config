### Steam Module

{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.steam.enable = lib.mkEnableOption "Enable Steam";

  config = lib.mkIf (config.steam.enable) {

    programs.steam.enable = true;
    hardware.steam-hardware.enable = true;
    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      minion
    ];

  };
}
