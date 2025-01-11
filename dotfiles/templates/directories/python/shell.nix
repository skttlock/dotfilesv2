let
  # pin version to 24.05
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };

  devPackages = with pkgs; [
      # install packages
      (python3.withPackages (python-pkgs: with python-pkgs; [
      ]))
    ];
in

  # alias pr="python run";
  # echo "alias pr=\"python run\"";
  pkgs.mkShellNoCC {
    packages = devPackages;
    SHELLTYPE = "dev";
    shellHook = ''


      echo "------------------------";
      echo "Entered $SHELLTYPE environment in:";
      pwd;
      echo "Using these packages:";
      python --version
      echo "";
      echo "           ==           ";
      echo "";
      echo "With these aliases:";
      echo "------------------------";
      '';
  }

