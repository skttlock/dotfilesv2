{pkgs, ...}: {
  imports = [
    ../../modules/neovim/neovim.nix
  ];

  # System package installs
  environment.systemPackages = with pkgs; [
    git
    cosmic-term
    zellij

    gparted

    fragments

    # should go to home.nix
    banana-cursor
    discord
    calibre
    gapless
    spotify
    gimp
    minder

    lyx
    onlyoffice-desktopeditors
    libreoffice-qt6-fresh
  ];
}
