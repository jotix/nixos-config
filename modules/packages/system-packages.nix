# share configuration

{ config, pkgs, ... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    exfat
    exfatprogs
    usbutils
    gnumake
    cmake
    gcc
    wl-clipboard
    xclip
    wget
    virt-manager
    gnucash
    gimp
    python311Full
    python311Packages.python-lsp-server
    qmk
    qmk-udev-rules
    qmk_hid
    zip
    unzip
    p7zip
    librecad
    libreoffice
    mpv
    gparted
    htop
    spotify
    fuse
    pass
    inkscape
    pciutils
    vial
    google-chrome
    google-fonts
    jetbrains-mono
    ubuntu_font_family
    neofetch
    nerdfonts
    dwt1-shell-color-scripts
    nextcloud-client
    gnome.gnome-tweaks
    gnome-browser-connector
    gnomeExtensions.tiling-assistant
    ventoy-full
    #libsForQt5.plasma-browser-integration
    #libsForQt5.kaccounts-integration
    #libsForQt5.kaccounts-providers
    #libsForQt5.kio-gdrive
  ]; # ++ (with lib; filter isDerivation (attrValues pkgs.plasma5Packages.kdeGear)); ## for install all kde apps

}
