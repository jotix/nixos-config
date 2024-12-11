### Steam Module

{ config, lib, ... }:

{
  options.steam.enable = lib.mkEnableOption "Enable Steam";
  
  config = lib.mkIf(config.steam.enable) {
    
    programs.steam.enable = true;
    hardware.steam-hardware.enable = true;
    programs.gamemode.enable = true;
    
  };
}
