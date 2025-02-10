let
  # pin version to 24.11
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11";
  pkgs = import nixpkgs {
    config = {};
    overlays = [];
  };

  # Use pip2nix to package any pip package for nix (when not available on NixPkgs)

  # packageOverrides = pkgs.callPackage ./python-packages.nix {};
  # python3 = pkgs.python3.override {inherit packageOverrides;};
  devPackages = with pkgs; [
    (python3.withPackages (pypkgs:
      with pypkgs; [
        # Then install them here
      ]))
  ];
  aliases = [
    {
      alias = "py";
      command = "python";
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
        for pkg in ${pkgs.lib.concatStringsSep " " (map (pkg: "${pkg.name}") devPackages)}; do
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
