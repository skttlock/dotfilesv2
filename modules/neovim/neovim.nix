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
        tabstop = 4;
        softtabstop = -1;
        shiftwidth = 4;
            };
      preventJunkFiles = true;
      undoFile = {
        enable = true;
        # path =
      };
            lsp.enable = true;
            #./languages.nix
      syntaxHighlighting = true;
      visuals = {
        fidget-nvim.enable = true;
        highlight-undo.enable = true;
        indent-blankline.enable = true;
      };

      autopairs.nvim-autopairs.enable = true;
      autocomplete.nvim-cmp.enable = true;
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
