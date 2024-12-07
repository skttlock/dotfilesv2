{ config, pkgs, ... }:

let
  homeDir = builtins.getEnv "HOME";
  existingNixPath = builtins.getEnv "NIX_PATH";
  nixPath = "${homeDir}/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels";
  # stylix.url = "github:danth/stylix";
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    # When using a different channel you can use `ref = "nixos-<version>"` to set it here
  });
in
  {
    imports = [
      nixvim.homeManagerModules.nixvim
    ];
  #description = "Fedora configuration, Oct 2024";

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "joshuaforeman";
  home.homeDirectory = "/home/joshuaforeman";
  home.stateVersion = "24.05"; # josh u are not mart enough to change this

  # Allow unfree software

  # Enable font configuration
  fonts.fontconfig.enable = true;

  ### PROGRAMS ###
  # enable and configure programs below...

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # 'enable' BASH and configure
  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };

    shellAliases = {
      # meta
      hms = "home-manager switch";
      hme = "home-manager edit";
      # cd
              # see "c"
      # za = "z --searchAdjacent";
      # lsd
      ls = "lsd";
      lsa = "lsd --almost-all";
      lst = "lsd --tree --depth=1";
      lstr = "lsd --tree --depth=2";
      lstre = "lsd --tree --depth=3";
      lstree = "lsd --tree --depth=4";
      # nix
      # nix-command = "nix --extra-experimental-features nix-command";
      ns = "nix-shell";
      # git
      # gd = "git diff";
      # ga = "git add";
      # git patch = "git add --patch";
      # gp = "git patch";
      # gc = "git commit";
      # gcm = "git commit --message";
      # gca = "git commit --amend";
      # gl  = "git log";
      # glo = "git log --oneline";
      # scripts
      # c = "./compile.sh";         # compiles project
                # or do i want something like c = "z --include=local, parent, child"
      # r = "./run.sh";             # runs project
      # cr = "./compile.sh; ./run.sh";
      # d = "./document.sh";        # generates documentation
      # v = "./view.sh"             # views documentation and/or project (i.e web page)
    };
    profileExtra = ''
      # .bash_profile

      # Get the aliases and functions
      if [ -f ~/.bashrc ]; then
        . ~/.bashrc
      fi

      # User specific environment and startup programs

      if [ -e /home/joshuaforeman/.nix-profile/etc/profile.d/nix.sh ]; then . /home/joshuaforeman/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
    '';

    bashrcExtra = ''
  # .bashrc

  # Source global definitions
      if [ -f /etc/bashrc ]; then
      . /etc/bashrc
      fi

  # User specific environment
      if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
      PATH="$HOME/.local/bin:$HOME/bin:$PATH"
      fi
      export PATH

  # Uncomment the following line if you don't like systemctl's auto-paging feature:
  # export SYSTEMD_PAGER=

  # User specific aliases and functions
      if [ -d ~/.bashrc.d ]; then
      for rc in ~/.bashrc.d/*; do
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

  # enable SSH and configure
  # programs.ssh = {
  #   enable = true;
  # };

  # enable STARSHIP and configure
  programs.starship = {
    enable = true;
    settings = {};
  };

  # enable NIXVIM and configure
  programs.nixvim = {
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
      set foldlevel=0

      set scrolloff=29

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

    colorscheme = "default";
    wrapRc = false;

    ### CURRENT
    plugins = {
      nix.enable = true;

      neorg = { 
        enable = true;
        modules = {
          "core.defaults" = {};
          "core.dirman" = {
            config = {
              workspaces = {
                home = "~/Documents/notes/home";
                work = "~/Documents/notes/work";
              };
            };
          };
        };
      };

      # mini.nvim, a collection of 40+ plugins
      mini = { 
        enable = true;
        modules = {

          # "editing experience"
          ai = {};
          operators = {};
          pairs = {};
          surround = {
            respect_selection_type = true;
          };

          comment = {};

          completion = {};

          # "general workflow"
          bracketed = {};
          files = {};
          jump2d = {
            view = {
              n_steps_ahead = 2;
            };
          };
          pick = {};

          # "appearance"
          # animate = {};         # might remove
          # hues = {
          #   background = "#1c2617";
          #   foreground = "#c3c8c2";
          #   n_hues = 8;
          #   plugins = {
          #     default = true;
          #   };
          # };
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

          #### TESTING
        };
      };

      # ui
      gitblame = {
        enable = true;
        settings = {
          delay = 50;
          message_template = "<summary>";
          set_extmark_options = {
            virt_text_pos = "right_align";
          };
        };
      };
      which-key = {
        enable = true;
        settings = {
          notify = true;
        };
      };

      ### TESTING

      # lsp
      treesitter.enable = true;
      lsp.enable = true;
      lsp.inlayHints = true;
      lsp-status.enable = true;
      lsp.servers = {
        nil_ls.enable = true;     # nix
        bashls.enable = true;     # bash

        ccls.enable = true;       # c/c++
        zls.enable = true;        # zig
        metals.enable = true;     # scala
        jdtls.enable = true;      # java... tbd
        # jdtls = { 
          # delay = 150;
        #};

        html.enable = true;       # html
        cssls.enable = true;      # css
        denols.enable = true;     # js
        marksman.enable = true;   # markdown

        # vale_ls.enable = true;    # technical writing

        jsonls.enable = true;     # json
      };
      # trouble.enable = true;

      lint.enable = true;

      ### TO BE ADDED

      # telescope.enable = true;

      # lazy loading
      #lz-n = {
      #  enable = true;
      #};

      #mini-align
      #mini-sessions
      #mini-clue? over whichkey?

      ### PREVIOUS

      # snippets
      # luasnip.enable = true;
      # vim-snippets.enable = true;
      # friendly-snippets.enable = true;

      # editor UI tools
      # helpview.enable = true;
      # fzf-lua.enable = true;

      # vim-css-color.enable = true;

      # render-markdown.enable = true;

      # emmet.enable = true;
      # dap.enable = true;
      # neotest.enable = true;
      # fugitive.enable = true;

      # other tools
      # vimtex.enable = true;


    # maybe later
      # project-nvim.enable = true;
      # ollama.enable = true;
      # typst-vim.enable = true;
      # sniprun.enable = true;
      # rest.enable = true;
      # refactoring.enable = true;
      # otter.enable = true;
      # guess-indent.enable = true;
    };
  };

  # enable GIT and configure
  programs.git = {
    enable = true;
    userName = "Joshua Foreman";
    userEmail = "9174473+skttlock@users.noreply.github.com"; # private, github-provided, commit email
    aliases = {
      aa = "add --all";
      cm = "commit --message";
      lo = "log --oneline";
      last = "log -1 HEAD --stat";
      # search log by author
      # short diff
      unstage = "reset HEAD";
      uncache = "rm --cached";

      s = "switch";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  # enable ZOXIDE and configure
  programs.zoxide = {
    enable = true;
  };

  #enable fastfetch
  programs.fastfetch.enable = true;

  # enable LSD
  programs.lsd = {
    enable = true;
    enableAliases = false;
    settings = {
      sorting.column = "extension";
    };
  };

  # enable GH
  programs.gh.enable = true;
  # enable FZF
  programs.fzf = {
    enable = true;
  };
  # enable LESS
  programs.less.enable = true;
  # enable TMUX
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    plugins = with pkgs; [
    ];
  };

  # enable RANGER and configure
  programs.ranger = {
    enable = true;
  };


  # TESTING #
  # stylix = {
  #   enable = true; 
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";
  #   fonts.monopace = {
  #     name = "Cousine Nerd Font";
  #     # package = <derivation nerdfonts>
  #   };
  #
  #   image = "./wallpapers/moon-lit.jpg";
  # };

  # programs.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true;
  # };
  # wayland.windowManager.sway = {
  #   enable = true;
  #   config = {
  #     modifier = "Mod4";
  #     # set default terminal
  #     # terminal = "";
  #     startup = [
  #       # Launch Firefox on start
  #       # {command = "firefox";}
  #       # Launch Obsidian on start
  #       # {command = "obsidian";}
  #       # Launch a terminal on start
  #       # {command = ;}
  #     ];
  #   };
  # };



  # LATER #
  # enable BORGMATIC and configure
  # programs.borgmatic = {
  #   enable = true;
  #   backups = {
  #     vaults = {
  #       location = {
  #         sourceDirectories = [
  #           "/$HOME/Documents/joshua-journal"
  #           "/$HOME/Documents/my-wiki"
  #           "/$HOME/Documents/school-notes"
  #         ];
  #         repositories = [ "/path/to/repo" ];
  #       };
  #     };
  #     projects = {
  #       location = {
  #         sourceDirectories = [ "/$HOME/Documents/Projects" ];
  #         repositories = [ "/path/to/repo" ];
  #       };
  #     };
  #     pictures = {
  #       location = {
  #         sourceDirectories = [ "/$HOME/Pictures ];
  #         repositories = [ "/path/to/repo" ];
  #       };
  #     };
  #     music = {
  #       location = {
  #         sourceDirectories = [ "/$HOME/Music" ];
  #         repositories = [ "/path/to/repo" ];
  #       };
  #     };
  #     video = {
  #       location = {
  #         sourceDirectories = [ "/$HOME/Videos" ];
  #         repositories = [ "/path/to/repo" ];
  #       };
  #     };
  #     library = {
  #       location = {
  #         sourceDirectories = [ "/$HOME/Documents/Library" ];
  #         repositories = [ "/path/to/repo" ];
  #       };
  #     };
  #   };
  # };



  ### DOTFILES ###
  # manage dotfiles here
  home.file = {
    # "../etc/nixos/configuration.nix".source = dotfiles/configuration.nix;
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # ".bashrc".source = dotfiles/.bashrc;
    # ".vimrc".source = dotfiles/.vimrc;

    # # You can also set the file content immediately.
    # ".bashrc".text = ''
    # '';
  };

  ### NIXPKGS ###
  # not preferred: install nixpkgs here to your environment
  home.packages = with pkgs; [
  # tui
    tldr

  # gui
    # discord
  # games
    # prismlauncher

  # system font
    (pkgs.nerdfonts.override { fonts = [ "Cousine" ]; })

    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  ### ENV VARIABLES ###
  # manage environment variables here
  home.sessionVariables = {
  };
}
