{ pkgs ? import <nixpkgs> {} }:

let
  aliases = [
    { alias = "ll"; command = "ls -la"; }
    { alias = "gs"; command = "git status"; }
  ];
in
pkgs.mkShell {
  buildInputs = [ pkgs.coreutils pkgs.git ];

  shellHook = ''
    echo "Setting up the following aliases:"
    echo ""

    ${builtins.concatStringsSep "\n" (map (def: ''
      alias ${def.alias}='${def.command}'
      echo "Alias set: ${def.alias} -> ${def.command}"
    '') aliases)}
  '';
}
