{pkgs, ...}: {
  # network via ssh
  programs.ssh = {
    enable = true;
  };
}
