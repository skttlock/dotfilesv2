let
  # pin version to 24.05
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };

  devPackages = with pkgs; [
    clojure
    hello
    git
  ];
  aliases = {
    hello = { short = "hi"; long = "hello"; };
  };
in
  pkgs.mkShell {
    packages = devPackages;
    SHELLTYPE = "dev";

    shellHook = ''
      echo "------------------------";
      echo "Entered $SHELLTYPE environment in:";
      pwd;
      echo "Using these packages:";
      for pkg in ${pkgs.lib.concatStringsSep " " (map (pkg: "${pkg.pname}-${pkg.version}") devPackages)}; do
        echo "Package: $pkg"
      done
      echo "";
      echo "           ==           ";
      echo "";
      echo "With these aliases:";
      for alias in ${pkgs.lib.concatStringsSep "\n" aliases}; do
        echo "Alias: $alias"
      done
      echo "------------------------";
      '';
  }
