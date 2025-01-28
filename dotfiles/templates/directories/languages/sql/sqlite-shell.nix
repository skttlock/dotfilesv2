let
  # pin version to 24.11
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };

  devPackages = with pkgs; [
    sqlite
  ];

  aliases = [
    {
      alias = "sqlite";
      command = "sqlite3";
    }
  ];
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
      ${builtins.concatStringsSep "\n" (map (def: ''
          alias ${def.alias}='${def.command}'
          echo "Alias set: ${def.alias} -> ${def.command}"
        '')
        aliases)}
        echo "------------------------";
    '';
  }
