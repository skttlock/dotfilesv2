{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { nixpkgs, home-manager, nvf, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # ↓ this is your home output in the flake schema, expected by home-manager
    "joshuaf@nixos" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        nvf.homeManagerModules.default # <- this imports the home-manager module that provides the options
        ./home.nix # <- your home entrypoint, `programs.nvf.*` may be defined here
      ];
    };
  };
}
