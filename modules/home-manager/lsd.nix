_: {
  programs.lsd = {
    enable = true;
    enableAliases = false;
    settings = {
      sorting = {
        column = "name";
        dir-grouping = "none";
      };
    };
  };
}
