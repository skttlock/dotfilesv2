_: {
  programs.nvf = {
    enable = true;
    settings.vim = {
      # appearance
      statusline.lualine = {
        enable = true;
        refresh = {
          statusline = 10;
          tabline = 10;
          winbar = 10;
        };
      };
      syntaxHighlighting = true;

      options.mouse = "";

      visuals = {
        fidget-nvim.enable = true;
        highlight-undo.enable = true;
        indent-blankline.enable = true;
      };

      #settings
      viAlias = true;
      vimAlias = true;

      preventJunkFiles = true;
      undoFile = {
        enable = true;
        # path =
      };
      spellcheck = {
        enable = true;
        programmingWordlist.enable = true;
      };

      # languages
      lsp = {
        formatOnSave = true;
        trouble.enable = true;
        lspSignature.enable = true;
        lsplines.enable = true;
        nvim-docs-view.enable = true;
      };

      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      treesitter = {
        enable = true;
        fold = true;
        highlight.enable = true;
        indent.enable = true;
        context.enable = true;
      };

      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        bash.enable = true;

        nu.enable = true;

        markdown.enable = true;
        html.enable = true;
        css.enable = true;

        ts.enable = true;

        python.enable = true;
      };

      #plugins
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

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false;
      };

      notify.nvim-notify.enable = true;

      utility = {
        surround.enable = true;
      };

      comments.comment-nvim.enable = true;
    };
  };
}
