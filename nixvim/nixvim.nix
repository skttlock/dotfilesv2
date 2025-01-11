{ libs, home, ... }:

with home.programs; {
    nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      opts = {
        smartcase = true;
        expandtab = true;
        shiftwidth = 4;
        tabstop = 4;
        relativenumber = true;
        number = true;
      };
      extraConfigVim = ''
        filetype plugin indent on
        syntax on
        set mouse=
        set autoindent
        set spell spelllang=en_us
        set foldmethod=indent
        set foldlevel=5

        set wildmenu
        " Make wildmenu behave like similar to Bash completion.
        set wildmode=list:longest
        " There are certain files that we would never want to edit with Vim.
        " Wildmenu will ignore files with these extensions.
        set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
        set showmode
        " show hidden characters
        set list
        set listchars=tab:>>,trail:-,nbsp:+
        " this command clears the last used search pattern:
        " :let @/ = ""
        " augroup vimrc
        "   au BufReadPre * setlocal foldmethod=indent
        "   au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
        " augroup END
      '';
      wrapRc = false;
      # - - - - - -
      #|APPEARANCE|
      # - - - - - -
      colorschemes.kanagawa = {
        enable = true;
        settings = {
          theme = "dragon";
          commentStyle.italic = true;
          compile = true;
          dimInactive = true;
          transparent = true;
          background.light = "lotus";
          background.dark = "dragon";
        };
      };
      # - - - -
      #|PLUGINS|
      # - - - -
      plugins = {
        mini = { 
          enable = true;
          mockDevIcons = true;
          modules = {
            # "editing experience"
            ai = {};
            operators = {};
            surround = {
              respect_selection_type = true;
            };
            comment = {};
            completion = {};
            clue = {};
            # "general workflow"
            bracketed = {};
            jump2d = {
              view = {
                n_steps_ahead = 2;
              };
            };
            # "appearance"
            icons = {};
            notify = {};
            statusline = {};
            tabline = {
              # format buffer line:
              # buffernum symbol filename.fiiletype
            };
            git = {};
            diff = {
              view = {
                style = "sign";
              };
            };
          };
        };
        ### Quality of Life plugins
        # reading
        helpview.enable = true;
        guess-indent.enable = true;
        # searching
        telescope.enable = true;
        harpoon.enable = true;
        # focusing
        zen-mode.enable = true;
        twilight.enable = true;
        ### Note-taking plugins
        zk.enable = true;
          # maybe C-n + Z
        vimtex.enable = false;
        telekasten.enable = false;
        mkdnflow.enable = false;
        orgmode.enable = false;
        ### Miscellaneous plugins
        mark-radar.enable = true;   # mark navigation
        sniprun.enable = true;      # visual-selected code execution
        colorizer.enable = true;    # highlight color codes
        neocord.enable = false;      # discord presence
        lz-n.enable = false;        # lazy load
        # something that draws... Venn.nvim seems great
        ### Coding plugins
        lint = {
          enable = true;
          lintersByFt = {
            janet = ["janet"];
          };
        };
        lsp = {
          enable = true;
          inlayHints = true;
          servers = {
            nil_ls.enable = true;     # nix
            bashls.enable = true;     # bash

            ccls.enable = true;       # c/c++
            zls.enable = false;       # zig
            janet_lsp = {             # janet
              enable = true;
              package = pkgs.janet;
            };
            metals.enable = false;    # scala
            jdtls.enable = true;      # java

            html.enable = true;       # html
            cssls.enable = true;      # css
            denols.enable = true;     # js/ts

            jsonls.enable = true;     # json

            marksman.enable = true;   # markdown
            vale_ls.enable = false;   # technical writing
            ltex.enable = false;      # latex
          };
        };
        lsp-status.enable = true;
        treesitter = {
          enable = true;
          folding = true;
          settings = {
            auto_install = true;
            highlight.enable = true;
            indent.enable = true;
            playground.enable = true;
          };
        };
        # repl interaction
        conjure = {
          enable = true;
        };
        # git
        gitblame = {              # in-line git blame message
          enable = true;
          settings = {
            delay = 500;
            message_template = "<summary>";
            set_extmark_options = {
              virt_text_pos = "right_align";
            };
          };
        };
        # test-driven development
        neotest.enable = false;     # better testing
          ## maybe C-n + T
        # debugging
        dap.enable = false;         # debug adapter protocol
        # snippets
        emmet.enable = false;       # superior web snippets, to be learned
        # commenting
        neogen.enable = true;       # better code annotations
          ## maybe C-n + G
        # maybe later...
        ollama.enable = false;      # interact with LLMs
      };
    };
}
