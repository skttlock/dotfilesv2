let
  # pin version to 24.05
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };

  devPackages = with pkgs; [
      # install packages

      # gcc                 # gnu compiler collection
      # zig                 # zig

      # jdk                 # java
      # jdt-language-server # java language server
      # scala               # scala

      deno                  # javascript
    ];
in

  pkgs.mkShellNoCC {
    packages = devPackages;
    SHELLTYPE = "dev";
    shellHook = ''
      alias dr="deno run";


      echo "------------------------";
      echo "Entered $SHELLTYPE environment in:";
      pwd;
      echo "Using these packages:";
      deno --version
      echo "";
      echo "           ==           ";
      echo "";
      echo "With these aliases:";
      echo "alias dr=\"deno run\"";
      echo "------------------------";
      '';
  }

