# share configuration

{ config, pkgs, ... }:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
    firefox
    jetbrains-mono
    ubuntu_font_family
    neofetch
    nerdfonts
    dwt1-shell-color-scripts
    nextcloud-client
    libsForQt5.plasma-browser-integration
  ] ++ (with lib; filter isDerivation (attrValues pkgs.plasma5Packages.kdeGear)); ## for install all kde apps

}
