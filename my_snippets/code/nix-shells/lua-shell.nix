let
  # pin version to 24.05
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
  aliases = [
    "alias dr='deno run'"
  ];
  # scripts = [
  #   "./scripts/"
  # ];
in

  pkgs.mkShellNoCC {
    packages = with pkgs; with luajitPackages; with lua54Packages; [

      # language
      lua
      # (dialects)
      luau
      tl                    # (pref. dialect)
      tl
      # compiler
      luajit

      luakit
      # build system
      cyan                  # (for teal)
      cyan

      # lsps
      teal-language-server
      teal-language-server


    ];

    SHELLTYPE = "dev";
    shellHook = ''
      echo "----------------------------------------";
      echo "|  Entered $SHELLTYPE environment in:         |";
      pwd;
      echo "|                                      |";
      echo "|  Using these packages:               |";
      deno --version
      echo "|                                      |";
      echo "|==  ==  ==  ==  ==  ==  ==  ==  ==  ==|";
      echo "|                                      |";
      echo "|                                      |";
      echo "|  With these aliases:                 |";
      for alias in ${toString aliases}; do
        eval $alias
        echo $alias
      done
      echo "|                                      |";
      echo "----------------------------------------";
      '';
  }

