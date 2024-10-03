{ config, pkgs, ... }:

{
  #description = "Fedora configuration, Oct 2024";


  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "joshuaforeman";
  home.homeDirectory = "/home/joshuaforeman";
  home.stateVersion = "24.05"; # josh u are not smart enough to change this

# install nixpkgs here to your environment
  home.packages = [
	pkgs.starship
	#pkgs.vim
	pkgs.ranger
	

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

# manage dotfiles here
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    #".bashrc".source = dotfiles/bashrc;
    #".vimrc".source = dotfiles/vimrc;

    # # You can also set the file content immediately.
    # ".bashrc".text = ''
    # '';
  };

# manage environment variables here
  home.sessionVariables = {
 #   VISUAL = "vim"; # doesn't seem to have any effect... check .bashrc
#    EDITOR = VISUAL;
  };

# enable and configure programs below...

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

# enable starship and configure
	programs.starship = { 
		enable = true;
		# config written to ~/.config/starship.toml
		settings = {};
	};

# enable vim and configure
    programs.vim = {
        enable = true;
        plugins = with pkgs.vimPlugins; [ vim-commentary ];
		settings = {};
    };

}
