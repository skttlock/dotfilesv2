{pkgs, ...}: {
  imports = [
    ./programs/neovim/neovim.nix
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
    cosmic-term

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
