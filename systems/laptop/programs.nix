{pkgs, ...}: {
  imports = [
    ../../modules/neovim/neovim.nix
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # System package installs
  environment.systemPackages = with pkgs; [
    git
    bat
    zellij

    cosmic-term

    gparted

    fragments

    # some of these should go to home.nix
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

    shotcut
    libsForQt5.kdenlive

    godot_4
    # love
    # raylib
    element-desktop
  ];
}
