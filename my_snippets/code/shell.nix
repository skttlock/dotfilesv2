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
    packages = with pkgs; [
      # install packages

      # gcc                 # gnu compiler collection
      # zig                 # zig

      # jdk                 # java
      # jdt-language-server # java language server
      # scala               # scala

      deno                  # javascript
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

