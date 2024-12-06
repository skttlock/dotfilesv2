let
  # pin version to 24.05
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
  aliases = [
    "alias dr='deno run'"
  ];
  scripts = [
    "./scripts/"
  ];
  devPackages = with pkgs; [
      deno                  # typescript
    ];

in

  pkgs.mkShellNoCC {
    packages = devPackages;
    SHELLTYPE = "dev";
    shellHook = ''
      echo "----------------------------------------";
      echo "|  Entered $SHELLTYPE environment in:\t\t\t\t|";
      pwd;
      echo "|";
      echo "|  Using these packages:\t\t\t\t|";
    for pkg in ${pkgs.lib.concatStringsSep " " (map (pkg: "${pkg.pname}-${pkg.version}") devPackages)}; do
      echo "|  $pkg --version \t\t\t\t|";
      echo "|  \t\t\t\t";
    done
      echo "|";
      echo "|";
      echo "|  With these aliases:\t\t\t\t|";
      for alias in ${toString aliases}; do
        eval $alias
        echo "$alias \t\t\t\t";
      done
      echo "|";
      echo "|";
      echo "|  And these scripts:\t\t\t|";
      for script in ${toString scripts}; do
        echo "$script \t\t\t\t"
      done
      echo "|\a\t\t\t\t|";
      echo "----------------------------------------";
      '';
  }

