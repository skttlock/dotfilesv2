{ config, pkgs, ... }:

let
  homeDir = builtins.getEnv "HOME";
  existingNixPath = builtins.getEnv "NIX_PATH";
  nixPath = "${homeDir}/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels";
in
  {
#description = "Fedora configuration, Oct 2024";


# Home Manager needs a bit of information about you and the paths it should
# manage.
home.username = "joshuaforeman";
home.homeDirectory = "/home/joshuaforeman";
home.stateVersion = "24.05"; # josh u are not smart enough to change this

# manage dotfiles here
home.file = {
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

# enable and configure programs below...

# Let Home Manager install and manage itself.
programs.home-manager.enable = true;

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
    ls = "lsd";
    lsa = "lsd --all";
    lstree = "lsd --tree";
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

# enable STARSHIP and configure
programs.starship = { 
  enable = true;
  settings = {};
};

# enable VIM and configure
programs.vim = {
  enable = true;
  defaultEditor = true;
  plugins = with pkgs.vimPlugins; [ vim-endwise vim-commentary vim-surround vim-fugitive vim-snipmate vim-snippets vim-nix ];
  settings = {
    smartcase = true;

    expandtab = true;
    shiftwidth = 4;
    tabstop = 4;

    relativenumber = true;
    number = true;
  };
  extraConfig = ''
    filetype on
    filetype plugin on
    filetype indent on
    set autoindent

    syntax on

    set foldmethod=indent
    set foldlevel=0

    set scrolloff=20

    set wildmenu
    " Make wildmenu behave like similar to Bash completion.
    set wildmode=list:longest

    " There are certain files that we would never want to edit with Vim.
    " Wildmenu will ignore files with these extensions.
    set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

    set showmode
  '';
};

# enable GIT and configure
programs.git = {
  enable = true;
  userName = "Joshua Foreman";
  userEmail = "9174473+skttlock@users.noreply.github.com"; # private, github-provided, commit email
  extraConfig = {
    init = {
      defaultBranch = "main";
    };
  };
};

programs.ranger = {
  enable = true;
};


# not preferred: install nixpkgs here to your environment
home.packages = [


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
];

# manage environment variables here
home.sessionVariables = {
};


}
