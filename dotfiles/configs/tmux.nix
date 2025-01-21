{pkgs, ...}: {
    programs.tmux = {
        enable = true;
      keyMode = "vi";
      plugins = with pkgs; [
            tmuxPlugins.mode-indicator
            tmuxPlugins.prefix-highlight
            tmuxPlugins.sidebar
            # tmuxPlugins.tmux-powerline
            # tmuxPlugins.tmux-floax
      ];
    };
}
