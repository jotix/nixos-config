# share configuration

{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/hardware/hardware-config.nix
    ./modules/home-manager/home-config.nix
    ./modules/emacs/emacs.nix
    ./modules/nvim/nvim.nix
    ./modules/syncthing/syncthing.nix
  ];

  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nixVersions.nix_2_8
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  ### kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_7;

  # Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];

  # Enable networking
  networking = {
    hostName = "jtx-nixos";
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
  };

  # enable virtualisation
  virtualisation.libvirtd = { 
    enable = true; 
    qemu = {
      ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ];
      };
      swtpm.enable = true;
    };
  };
  #virtualisation.tpm.enable = true;
  programs.dconf.enable = true;

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF8";

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "es_AR.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LANG     = "en_US.UTF8";
    LANGUAGE = "en_US.UTF8";
    LC_ALL   = "es_AR.UTF8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
  };

  services.desktopManager.plasma6.enable = true;
  
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jotix = {
    isNormalUser = true;
    description = "jotix";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    EDITOR = "nano";
    VISUAL = "nano";
  };

  # shellAliases
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake .#$HOSTNAME";
    camara = "mpv rtsp://jujodeve:SuperJoti3275@192.168.0.6/stream1 --profile=low-latency --no-audio";
  };
  
  ##### List packages installed in system profile. #############################
  # To search, run: $ nix search wget
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
    gimp
    python311Full
    python311Packages.python-lsp-server
    cargo
    rustc
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
    google-chrome
    google-fonts
    jetbrains-mono
    ubuntu_font_family
    neofetch
    nerdfonts
    dwt1-shell-color-scripts
    kdePackages.kate
  ];

  # steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;

  # bash
  users.defaultUserShell = pkgs.bash;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    #pinentryPackage = pkgs.pinentry-curses;
  };

  # fuse
  programs.fuse.userAllowOther = true;

  ##### List services that you want to enable ##################################

  services = {
    keyd = {
      enable =true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              f13 = "macro(toona)";
              f16 = "macro(jujodeve@gmail.com)";
            };
          };
        };
      };
    };
    openssh.enable = true;
    fstrim.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.brlaser pkgs.cups-zj-58 ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  hardware.keyboard.qmk.enable = true;
}
