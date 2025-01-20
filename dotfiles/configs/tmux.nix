{pkgs, ...}: {
    programs.tmux = {
        enable = true;
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins; [
            mode-indicator
            prefix-highlight
            sidebar
      ];
    };
}
