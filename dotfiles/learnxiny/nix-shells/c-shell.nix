let
  # pin version to 24.05
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

  pkgs.mkShellNoCC {
    packages = with pkgs; [
      # install packages

      # gcc                 # gnu compiler collection
      # zig                 # zig

      # jdk                 # java
      # jdt-language-server # java language server
      # scala               # scala

      deno                  # javascript
    ];

    SHELLTYPE = "dev";
    shellHook = ''
      echo "------------------------";
      echo "Entered $SHELLTYPE environment in:";
      pwd;
      echo "Using these packages:";

      deno --version


      echo "------------------------";
      '';
  }

