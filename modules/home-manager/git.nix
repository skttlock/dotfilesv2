{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Joshua Foreman";
    userEmail = "9174473+skttlock@users.noreply.github.com"; # private, github-provided, commit email
    aliases = {
      aa = "add --all";
      c = "commit";
      cm = "commit --message";
      ca = "commit --amend";
      l = "log";
      lo = "log --oneline";
      last = "log -1 HEAD --stat";
      # search log by author
      # short diff
      unstage = "reset HEAD";
      uncache = "rm --cached";
      patch = "git add --patch";
      s = "switch";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
    # plugins
    delta.enable = true;
  };

  programs.gh.enable = true;
}
