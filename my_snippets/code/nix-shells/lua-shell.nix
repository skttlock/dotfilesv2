let
  # pin version to 24.05
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
  # aliases = [
  # ];
  # scripts = [
  #   "./scripts/"
  # ];
in

  pkgs.mkShellNoCC {
    packages = with pkgs; with lua52Packages; [
      # language
      lua
      # (dialects)
      luau
      tl                    # (pref. dialect)
      # compiler
      luajit
      # build system
      cyan                  # (teal)
      # formatter
      luaformatter
      # lsp
      teal-language-server

      # other
      # browser framework
      luakit
    ];

    SHELLTYPE = "dev";
    shellHook = ''
      echo "----------------------------------------";
      echo "|  Entered $SHELLTYPE environment in:         |";
      pwd;
      echo "|                                      |";
      echo "|  Using these packages:               |";
      for package in ${toString pkgs.mkShellNoCC}; do      
        echo "|  $package --version                  |";
      echo "|                                      |";
      echo "|==  ==  ==  ==  ==  ==  ==  ==  ==  ==|";
      echo "|                                      |";
      echo "|                                      |";
      echo "|  With these aliases:                 |";
      for alias in ${toString aliases}; do
        echo "|  $alias                              |";
      done
      echo "|                                      |";
      echo "----------------------------------------";
      '';
  }

