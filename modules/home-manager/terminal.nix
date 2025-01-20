_: {
    imports = [
        ../../dotfiles/configs/tmux.nix
    ];
  # ----------------------
  # | TERMINAL UTILITIES |
  # ----------------------
  programs = {
    # TERMINAL EMULATOR
    ghostty = {
      enable = true;
    };
    zoxide.enable = true; # better cd, meh
    fzf.enable = true; # fuzzy find
    ranger.enable = true; # tui file system navigation
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
