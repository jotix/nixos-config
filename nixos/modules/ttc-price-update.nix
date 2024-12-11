{ pkgs, ... }:

let

script = ''
#!/usr/bin/env bash

TTC_PATH="/steamapps/compatdata/306130/pfx/drive_c/users/steamuser/Documents/Elder Scrolls Online/live/AddOns/TamrielTradeCentre"

JTX_STEAM_PATH="/mnt/jtx-ssd/SteamLibrary"

FFM_STEAM_PATH="/home/jotix/.local/share/Steam"

if [[ "$HOSTNAME" == "jtx-nixos" ]]; then
    TTC_PATH=$JTX_STEAM_PATH$TTC_PATH
else
    TTC_PATH=$FFM_STEAM_PATH$TTC_PATH
fi

curl -o ~/Downloads/PriceTable.zip 'https://us.tamrieltradecentre.com/download/PriceTable'
unzip -o ~/Downloads/PriceTable.zip -d ~/Downloads/PriceTable
cd ~/Downloads/PriceTable

rsync -auvzhPX --progress ~/Downloads/PriceTable/. "$TTC_PATH"
'';

ttc-price-update = pkgs.writeShellApplication {
  name = "ttc-price-update";

  runtimeInputs = [ pkgs.curl pkgs.unzip pkgs.rsync ];

  text = script;
};

in

{
  environment.systemPackages = [ ttc-price-update ];
}
