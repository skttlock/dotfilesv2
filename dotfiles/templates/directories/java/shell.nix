let
  # pin version to 24.05
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

  pkgs.mkShellNoCC {
    packages = with pkgs; [
      # install package
      jdk
    ];

    GREETING = "Entered dev-environment with:";
    shellHook = ''
      echo "------------";
      pwd;
      echo $GREETING;
      echo $(java --version);
      echo $(javac --version);
      '';
  }

