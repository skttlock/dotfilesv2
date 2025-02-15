{pkgs, ...}: {
  imports = [
    ../../modules/neovim/neovim.nix
  ];

  # System package installs
  environment.systemPackages = with pkgs; [
    git
    bat
  ];
}
