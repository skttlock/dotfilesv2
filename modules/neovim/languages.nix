_: {
    programs.nvf.settings.vim.lsp.formatOnSave = true;
  programs.nvf.settings.vim.languages = {
    enableLSP = true;
    enableFormat = true;
    enableTreesitter = true;
    enableExtraDiagnostics = true;

    nix.enable = true;
    bash.enable = true;

    nu.enable = true;

    markdown.enable = true;
    markdown.extensions.render-markdown-nvim.enable = true;
    html.enable = true;
    css.enable = true;

    ts.enable = true;

    python.enable = true;
  };
}
