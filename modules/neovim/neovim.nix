_: {
  imports = [
    ./debugger.nix
    #./keybinds.nix
    ./git.nix
    ./languages.nix
    ./spellcheck.nix
    ./statusline.nix
    ./treesitter.nix
  ];
  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      options = {
        mouse = "";
        tabstop = 2;
        softtabstop = -1;
        shiftwidth = 2;
      };
      preventJunkFiles = true;
      undoFile = {
        enable = true;
        # path =
      };
      lsp.enable = true;
      #./languages.nix

      # appearance
      syntaxHighlighting = true;
      visuals = {
        fidget-nvim.enable = true;
        highlight-undo.enable = true;
        indent-blankline.enable = true;
      };
      ui = {
        borders.plugins.which-key.enable = true;
        # modes-nvim.enable = true;
        # nvim-ufo.enable = true;
        smartcolumn.enable = true;
      };

      autopairs.nvim-autopairs.enable = true;
      autocomplete = {
        nvim-cmp = {
          enable = true;
          mappings = {
            close = "<Left>";
            confirm = "<Right>";
            next = "<Down>";
            previous = "<Up>";
          };
        };
      };
      snippets.luasnip.enable = true;

      tabline = {
        nvimBufferline.enable = true;
      };

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      telescope.enable = true;

      notify.nvim-notify.enable = true;

      utility = {
        surround.enable = true;
      };

      comments.comment-nvim.enable = true;
    };
  };
}
