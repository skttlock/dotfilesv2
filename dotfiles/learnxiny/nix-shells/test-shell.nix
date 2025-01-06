let
  # pin version to 24.05
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };

  myPackages = with pkgs; [
    hello
    git
  ];
in
pkgs.mkShell {
  packages = myPackages;

  shellHook = ''
    for pkg in ${pkgs.lib.concatStringsSep " " (map (pkg: "${pkg.pname}-${pkg.version}") myPackages)}; do
      echo "Package: $pkg"
    done
  '';
}
