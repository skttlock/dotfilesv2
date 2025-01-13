{ config, pkgs, inputs, ... }:

let
  homeDir = builtins.getEnv "HOME";
  existingNixPath = builtins.getEnv "NIX_PATH";
  nixPath = "${homeDir}/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels";
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    # When using a different channel you can use `ref = "nixos-<version>"` to set it here
  });
in {
  imports = [
    nixvim.homeManagerModules.nixvim
    # ./nixvim/nixvim.nix
    # inputs.nvf.homeManagerModules.default
    # ./neovim/neovim.nix
  ];
  fonts.fontconfig.enable = true;


  #========
  #|SYSTEM|
  #========
  dconf = {
    settings = {
      "org/gnome/mutter" = {
        edge-tiling  = "false";
      };
      "org/gnome/settings-daemon/plugins/power" = {
        lid-close-suspend-with-external-monitor = "nothing";
      };
    };
  };

  #======
  #|HOME|
  #======
  home = {
    username = "joshuaf";
    homeDirectory = "/home/joshuaf";
    stateVersion = "24.11"; # josh u are not mrt enough to change this
    sessionPath = [
      "$HOME/.bin/scripts"
      "$HOME/.apps/"
      "$HOME/Templates"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    # dotfiles
    file = {
#     "/.local/share/todo.txt" = { #this is a directory, yes, I know.
#       source = ./todo;
#       recursive = true;
#     };
      "/.bin/scripts" = {
        source = ./dotfiles/scripts;
        recursive = true;
        executable = true;
      };
    };
  };

  #==========
  #|PACKAGES|
  #==========
  home.packages = with pkgs; [
    # fonts
    cascadia-code # monocode
    open-sans     # sans serif
    arcticons-sans # sans serif
    poly          # serif
    inriafonts    # sans serif + serif
    # tui
    tldr
    # gui
  ];

  #==========
  #|PROGRAMS|
  #==========
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    # shell language... maybe go fish one day
    bash = {
      enable = true;
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
      shellAliases = {
        hms = "home-manager switch";
        hme = "home-manager edit";
        nre = "sudoedit /etc/nixos/configuration.nix";
        nrs = "nixos-rebuild switch --use-remote-sudo";
        # cd
        # cdb = "cd -";
        # za = "zoxide add .";
        # za = "z --searchAdjacent";
        # lsd
        lsa = "lsd --almost-all";
        lst = "lsd --tree --depth=1";
        lstr = "lsd --tree --depth=2";
        lstre = "lsd --tree --depth=3";
        lstree = "lsd --tree --depth=4";
        # nix
        nix-command = "nix --extra-experimental-features nix-command";
        ns = "nix-shell";
      };
      profileExtra = ''
        # .bash_profile
        if [ -f ~/.bashrc ]; then
        . ~/.bashrc
        fi
        # User specific environment and startup programs
        if [ -e /home/joshuaforeman/.nix-profile/etc/profile.d/nix.sh ]; then . /home/joshuaforeman/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
      '';
      bashrcExtra = ''
        # .bashrc
        if [ -f /etc/bashrc ]; then
          . /etc/bashrc
        fi
        # User specific environment
        if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
          PATH="$HOME/.local/bin:$HOME/bin:$PATH"
        fi
        export PATH
        # export SYSTEMD_PAGER=
        # User specific aliases and functions
        if [ -d ~/.bashrc.d ]; then
          for rc in ~/.bashrc.d/\*; do
            if [ -f "$rc" ]; then
              . "$rc"
            fi
          done
        fi
        unset rc
        eval "$(starship init bash)"
        eval "$(zoxide init bash)"
      '';
    };
    # version control
    git = {
      enable = true;
      userName = "Joshua Foreman";
      userEmail = "9174473+skttlock@users.noreply.github.com"; # private, github-provided, commit email
      aliases = {
        aa = "add --all";
        c = "commit";
        cm = "commit --message";
        ca = "commit --amend";
        l = "log";
        lo = "log --oneline";
        last = "log -1 HEAD --stat";
        # search log by author
        # short diff
        unstage = "reset HEAD";
        uncache = "rm --cached";
        patch = "git add --patch";
        s = "switch";
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
    gh.enable = true;
    # network via ssh
    ssh = { enable = true; };
    # editors
	# ----------
	# | NEOVIM |
	# ----------
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
    emacs.enable = true;
    # 
    lsd = {
      enable = true;
      enableAliases = false;
      settings = {
        sorting.column = "extension";
      };
    };
    zathura.enable = false;        # document viewer, needs config
    zoxide.enable = true;         # better cd, meh
    fzf.enable = true;            # fuzzy find
    ranger.enable = true;         # tui file system navigation
    tmux = {
      enable = true;
      keyMode = "vi";
      plugins = [
      ];
    };
    less.enable = true;
    zk.enable = true;

    #------------
    #|APPEARANCE|
    #------------
    fastfetch.enable = true;
    starship = {
      enable = true;
      settings = {};
    };
  };
}
