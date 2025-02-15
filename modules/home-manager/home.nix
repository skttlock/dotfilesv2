{pkgs, ...}: {
  imports = [
    ./terminal.nix
    ./bash.nix
    ./git.nix
    ./ssh.nix
    ./lsd.nix
  ];
  fonts.fontconfig.enable = true;

  #========
  #|SYSTEM|
  #========
  dconf = {
    settings = {
      "org/gnome/mutter" = {
        edge-tiling = "false";
      };
      "org/gnome/settings-daemon/plugins/power" = {
        lid-close-suspend-with-external-monitor = "nothing";
      };
    };
  };
  gtk.cursorTheme = {
    package = pkgs.banana-cursor;
    name = "Banana";
  };

  #======
  #|HOME|
  #======
  home = {
    # file.".icons/default".source = "${pkgs.banana-cursor}/shares/icons/Banana";
    pointerCursor = {
      package = pkgs.banana-cursor;
      name = "Banana";
      gtk.enable = true;
      x11.enable = true;
      hyprcursor.enable = true;
    };

    username = "joshuaf";
    homeDirectory = "/home/joshuaf";
    stateVersion = "24.05"; # josh u are not mrt enough to change this
    sessionPath = [
      "$HOME/.bin/scripts"
      "$HOME/.apps/"
      "$HOME/Templates"
    ];
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    file = {
      #     "/.local/share/todo.txt" = { #this is a directory, yes, I know.
      #       source = ./todo;
      #       recursive = true;
      #     };
      "/Templates" = {
        source = ../../dotfiles/templates/documents;
        recursive = true;
        executable = false;
      };
      "/.bin/scripts" = {
        source = ../../dotfiles/scripts;
        recursive = true;
        executable = true;
      };
      "./bin/snippets/mine" = {
        source = ../../dotfiles/templates/snippets;
        recursive = true;
        executable = false;
      };
    };
  };

  home.packages = with pkgs; [
    # fonts are declared in ../fonts.nix
    # tui
    tldr
    openpomodoro-cli
    # gui
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
