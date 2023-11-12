# share configuration

{ config, pkgs, ... }:

{
  home-manager.users.jotix = { pkgs, ... }:
  {
    programs.neovim = {
      enable = true;
      #defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        vim-startify
        lualine-nvim
        telescope-nvim
        plenary-nvim
        nvim-treesitter
        nvim-treesitter-parsers.python
        nvim-treesitter-parsers.haskell
        nvim-treesitter-parsers.c
        undotree
        nerdtree
        toggleterm-nvim
        tokyonight-nvim
        lsp-zero-nvim
      ];
    };

    xdg.configFile = {
      "nvim/init.lua" = {
        enable = true;
        source = ./init.lua;
      };
    };
  };
}
