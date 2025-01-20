{pkgs, ...}: {
  programs.lsd = {
    enable = true;
    enableAliases = false;
    settings = {
      sorting.column = "extension";
    };
  };
}
