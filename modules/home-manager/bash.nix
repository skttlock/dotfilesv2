_: {
  # shell language... maybe go fish one day
  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
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
}
