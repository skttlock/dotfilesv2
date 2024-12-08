{ config, pkgs, ... }:

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
    };
  };

  #======
  #|HOME|
  #======
  home = {
    username = "joshuaforeman";
    homeDirectory = "/home/joshuaforeman";
    stateVersion = "24.05"; # josh u are not mrt enough to change this
    sessionPath = [
      "$HOME/.bin/scripts"
      "$HOME/.apps/"
    ];
    # dotfiles
    file = {
      "/.local/share/todo.txt" = {
        source = ./my_todo;
        recursive = true;
      };
      "/.bin/scripts" = {
        source = ./dotfiles/scripts;
        recursive = true;
        executable = true;
      };
      "/.bin/applications" = {
        source = ./dotfiles/applications;
        recursive = true;
        executable = true;
      };
      "/.bin/.snippets" = {
        source = ./dotfiles/snippets;
        recursive = true;
      };
      "/Templates" = {
        source = ./dotfiles/templates;
        recursive = true;
      };
    };

    #==========
    #|PACKAGES|
    #==========
    packages = with pkgs; [
      # fonts
      cascadia-code # monocode
      open-sans     # sans serif
      arcticons-sans # sans serif
      poly          # serif
      inriafonts    # sans serif + serif
      # tui
      tldr
    ];
  };

  #==========
  #|PROGRAMS|
  #==========
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    bash = {
      enable = true;
      sessionVariables = {
        EDITOR = "vim";
        VISUAL = "vim";
      };
      shellAliases = {
        hms = "home-manager switch";
        hme = "home-manager edit";
        # cd
        # cdb = "cd -";
        za = "zoxide add .";
        # za = "z --searchAdjacent";
        # lsd
        ls = "lsd";
        lsa = "lsd --almost-all";
        lst = "lsd --tree --depth=1";
        lstr = "lsd --tree --depth=2";
        lstre = "lsd --tree --depth=3";
        lstree = "lsd --tree --depth=4";
        # nix
         nix-command = "nix --extra-experimental-features nix-command";
        ns = "nix-shell";
        # git
        gd = "git diff";
        ga = "git add";
        gp = "git patch";
        gc = "git commit";
        gcm = "git commit --message";
        gca = "git commit --amend";
        gl  = "git log";
        glo = "git log --oneline";
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
    git = {
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
    ssh = { enable = true; };
    borgmatic = {
      enable = false;
      backups = {
        vaults = {
          location = {
            sourceDirectories = [
              "/$HOME/Documents/joshua-journal"
              "/$HOME/Documents/my-wiki"
              "/$HOME/Documents/school-notes"
            ];
            repositories = [ "/path/to/repo" ];
          };
        };
        projects = {
          location = {
            sourceDirectories = [ "/$HOME/Documents/Projects" ];
            repositories = [ "/path/to/repo" ];
          };
        };
        pictures = {
          location = {
            sourceDirectories = [ "/$HOME/Pictures" ];
            repositories = [ "/path/to/repo" ];
          };
        };
        music = {
          location = {
            sourceDirectories = [ "/$HOME/Music" ];
            repositories = [ "/path/to/repo" ];
          };
        };
        video = {
          location = {
            sourceDirectories = [ "/$HOME/Videos" ];
            repositories = [ "/path/to/repo" ];
          };
        };
        library = {
          location = {
            sourceDirectories = [ "/$HOME/Documents/Library" ];
            repositories = [ "/path/to/repo" ];
          };
        };
      };
    };
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
      # - - - - - -
      #|APPEARANCE|
      # - - - - - -
      colorschemes.kanagawa = {
        enable = true;
        settings = {
          commentStyle.italic = true;
          compile = true;
          dimInactive = true;
          transparent = true;
        };
      };
      wrapRc = false;
      # - - - -
      #|PLUGINS|
      # - - - -
      plugins = {
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
        ### CURRENT
        nix.enable = true;
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
        treesitter.enable = true;
        lsp-status.enable = true;
        lsp = {
          enable = true;
          inlayHints = true;
          servers = {
            nil_ls.enable = true;     # nix
            bashls.enable = true;     # bash
            ccls.enable = true;       # c/c++
            zls.enable = true;        # zig
            metals.enable = true;     # scala
            jdtls.enable = true;      # java... tbd
            html.enable = true;       # html
            cssls.enable = true;      # css
            denols.enable = true;     # js
            marksman.enable = true;   # markdown
          # vale_ls.enable = true;    # technical writing
          jsonls.enable = true;     # json
          };
        };
          # incomplete
          # general
        # vimtex.enable = true;
        # trouble.enable = true;
        # lint.enable = true;
        # telescope.enable = true;

          # lazy loading
        #lz-n = {
        #  enable = true;
        #};

          # snippets
          # testing
        # emmet.enable = true;
        # dap.enable = true;
        # neotest.enable = true;
        # fugitive.enable = true;

         # maybe later
        # project-nvim.enable = true;
        # ollama.enable = true;
        # typst-vim.enable = true;
        # sniprun.enable = true;
        # rest.enable = true;
        # refactoring.enable = true;
        # otter.enable = true;
        # guess-indent.enable = true;
        vim-css-color.enable = true;
      };
    };
    lsd = {
      enable = true;
      enableAliases = false;
      settings = {
        sorting.column = "extension";
      };
    };
    zoxide.enable = true;
    fzf.enable = true;
    ranger.enable = true;
    tmux = {
      enable = true;
      keyMode = "vi";
      plugins = [
      ];
    };
    less.enable = true;
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
