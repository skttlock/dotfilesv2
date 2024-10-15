{ config, pkgs, ... }:

let
  homeDir = builtins.getEnv "HOME";
  existingNixPath = builtins.getEnv "NIX_PATH";
  nixPath = "${homeDir}/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels";
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
  home.stateVersion = "24.05"; # josh u are not smart enough to change this

  # enable and configure programs below...

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # testing sway
  # programs.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true;
  # };
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      # Use wezterm as default terminal
      terminal = "wezterm";
      startup = [
        # Launch Firefox on start
        # {command = "firefox";}
        # Launch Obsidian on start
        # {command = "obsidian";}
        # Launch a terminal on start
        # {command = ;}
      ];
    };
  };



  # 'enable' BASH and configure
  programs.bash = {
    enable = true;
    sessionVariables = {
      NIX_PATH = if existingNixPath != "" then "${nixPath}:${existingNixPath}" else nixPath;
      EDITOR = "vim";
      VISUAL = "vim";
    };

    shellAliases = {
      hms = "home-manager switch";
      hme = "home-manager edit";
      ls = "lsd";
      lsa = "lsd --all";
      lst = "lsd --tree";
      lstree = "lsd --tree --depth=3";
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
    '';
  };

  # enable SSH and configure
  programs.ssh = {
    enable = true;
  };

  # enable STARSHIP and configure
  programs.starship = {
    enable = true;
    settings = {};
  };

  # enable NIXVIM and configure
  programs.nixvim = {
    enable = true;
    opts = {
      smartcase = true;

      expandtab = true;
      shiftwidth = 4;
      tabstop = 4;

      relativenumber = true;
      number = true;
    };
    extraConfigVim = ''
      filetype on
      filetype plugin on
      filetype indent on
      set autoindent

      syntax on

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
    '';
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    colorschemes.base16 = {
      enable = true;
      colorscheme = "solarized-dark";
    };
    # auto-dark
    plugins = {

      # language tools
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          bashls.enable = true;
          nil_ls.enable = true;
          java_language_server.enable = true;
          ccls.enable = true;

          html.enable = true;
          cssls.enable = true;
          denols.enable = true;
          marksman.enable = true;
        };
      };
      lsp-lines.enable = true;
      lsp-status.enable = true;
      lspkind.enable = true;
      treesitter.enable = true;
      trouble.enable = true;

      # editor tools
      airline = {
        enable = true;
        settings.theme = "dark";
      };
      web-devicons.enable = true;
      which-key = {
        enable = true;
        settings = {
          notify = true;
        };
      };
      # helpview.enable = true;
      # fzf-lua.enable = true;

      rainbow-delimiters.enable = true;
      vim-css-color.enable = true;
      illuminate.enable = true;

      render-markdown.enable = true;
      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
          current_line_blame_opts.delay = 500;
        };
      };

      # editing tools
      commentary.enable = true;
      nvim-surround.enable = true;
      endwise.enable = true;
      lint.enable = true;
      trim.enable = true;

      # programming tools
      luasnip.enable = true;
      # vim-snippets.enable = true;
      friendly-snippets.enable = true;
      emmet.enable = true;
      dap.enable = true;
      neotest.enable = true;
      fugitive.enable = true;

      # other tools
      nix.enable = true;
      # vimtex.enable = true;


    # maybe later
    # project-nvim.enable = true;
      # telescope.enable = true;
      # neorg.enable = true;
      # ollama.enable = true;
      # typst-vim.enable = true;
      # sniprun.enable = true;
      # rest.enable = true;
      # refactoring.enable = true;
      # otter.enable = true;
      # mini.enable = true;
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
      unstage = "reset HEAD";
      uncache = "rm --cached";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  #enable fastfetch
  programs.fastfetch.enable = true;

  # enable LSD
  programs.lsd = {
    enable = true;
    enableAliases = false;
  };

  # enable GH
  #programs.gh.enable = true;
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




  # manage dotfiles here
  home.file = {
    # "../etc/nixos/configuration.nix = dotfiles/configuration.nix;
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    #".bashrc".source = dotfiles/bashrc;
    # ".vimrc".source = dotfiles/.vimrc;

    # # You can also set the file content immediately.
    # ".bashrc".text = ''
    # '';
  };

  # not preferred: install nixpkgs here to your environment
  home.packages = [
    pkgs.tldr


  # # It is sometimes useful to fine-tune packages, for example, by applying
  # # overrides. You can do that directly here, just don't forget the
  # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
  # # fonts?
  # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

  # # You can also create simple shell scripts directly inside your
  # # configuration. For example, this adds a command 'my-hello' to your
  # # environment:
  # (pkgs.writeShellScriptBin "my-hello" ''
  #   echo "Hello, ${config.home.username}!"
  # '')

  # creat backup scripts here?
  # or just link em..?
];

  # manage environment variables here
  home.sessionVariables = {
  };
}
