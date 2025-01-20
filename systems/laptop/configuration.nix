# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Include system config
    ./system.nix
    ./programs.nix
    ../../modules/fonts.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joshuaf = {
    isNormalUser = true;
    description = "Joshua Foreman";
    extraGroups = ["networkmanager" "wheel"];
  };

  xdg.portal.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
