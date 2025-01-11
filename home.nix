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
    ./nixvim/nixvim.nix
    inputs.nvf.homeManagerModules.default
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
