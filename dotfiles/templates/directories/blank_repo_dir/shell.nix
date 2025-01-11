let
  # pin version to 24.05
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
  aliases = [
  ];
  scripts = [
  ];
  devPackages = with pkgs; [
  ];
in
  pkgs.mkShellNoCC {
    packages = devPackages;
    SHELLTYPE = "dev";
    shellHook = ''
      echo "----------------------------------------";
      echo "|  Entered $SHELLTYPE environment in:";
      echo "|  $(pwd)";
      echo "|";
      echo "|  Using these packages:";
    for pkg in ${pkgs.lib.concatStringsSep " " (map (pkg: "${pkg.pname}@${pkg.version}") devPackages)}; do
      echo "|  $pkg";
    done
      echo "----------------------------------------";
      '';
  }
    #   echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
    #   echo "|  With these aliases:";
    # for alias in ${toString aliases}; do
    #   eval alias $alias;
    #   echo "|  $alias";
    # done
    #   echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
    #   echo "|  And these scripts:";
    # for script in ${toString scripts}; do
    #   echo "|  $script"
    # done
