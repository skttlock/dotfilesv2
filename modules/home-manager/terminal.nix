_: {
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
