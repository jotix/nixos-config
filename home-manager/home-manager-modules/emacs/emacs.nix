### Emacs Module

{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.emacs.enable = lib.mkEnableOption "Enable Emacs";

  config = lib.mkIf (config.emacs.enable) {

    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages =
        epkgs: with epkgs; [
          vertico
          marginalia
          consult
          orderless
          multiple-cursors
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
          treemacs
          org-present
          visual-fill-column
          geiser
          geiser-guile
          eshell-info-banner
          ace-window
          markdown-mode
          pdf-tools
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
