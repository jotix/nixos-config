
{ config, pkgs, ... }:

{
  
  home-manager.users.jotix = { pkgs, ... }:
  {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs29;
      extraPackages = epkgs: with epkgs; [
        ivy
        ivy-rich
        counsel
        swiper
        dashboard
        nerd-icons
        all-the-icons
        all-the-icons-dired
        spacemacs-theme
        spaceline
        vterm
        rainbow-delimiters
        which-key
        beacon
        hungry-delete
        sudo-edit
        nix-mode
        undo-tree
        org-auto-tangle
        org-bullets
        toc-org
        magit
        eshell-git-prompt
        company
        sly
        treemacs
        org-present
        visual-fill-column
        geiser-guile
      ];
    };

    services.emacs = {
      enable = true;
      client.enable = true;
      client.arguments = [
        "-c"
        "-a emacs"
      ];
    };

    xdg.configFile = {
      "emacs/init.el" = {
        enable = true;
        source = ./init.el;
      };
      "emacs/eshell/alias" = {
        enable = true;
        source = ./eshell/alias;
      };
      "emacs/eshell/profile" = {
        enable = true;
        source = ./eshell/profile;
      };
    };
  };

}
