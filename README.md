# config (jan 2025)

_Managed with the Nix Home-Manager tool._

> [!NOTE]
> to surpress warning stating that `.../per-user/root/channels` does not exist,
> make said directories.

## To-Do

- [x] restructure
- [x] update file links per new structure
- [-] update inputs to... unstable or 24.11
  - [ ] update nixpkgs/NixOS
  - [ ] update home-manager
- [x] implement flake
  - [x] test without home-manager
  - [x] integrate home-manager
  - [x] test with home-manager
- [ ] check for selective update capability with flake usage
      (`home-manager switch`)
- [ ] scripts get linked appropriately

### Configuration

- [ ] `zk` (`~/Documents/Zettle`)
- [ ] `zellij`
  - [ ] aliases for common sessions
  - [ ] layouts??
- [ ] `ranger`
- [x] `lsd`
- [ ] `bat`
  - [ ] color scheme?
- [ ] `sops-nix` to hold secrets such as `.ssh` keys
- [ ] `please`
  - [ ] package for nix
- [ ] "profile" stuff?

  - [ ] profile picture?

  ### TUI-Only Config

  - [ ] `bat`
  - [ ] `please`
  - [ ] `ranger`
  - [ ] `nvf`
  - [ ] `git`
  - [ ] `github`
  - [ ] `zellij`
  - [ ] `zk`
  - [ ] a web browser
    - `lynx`
    - `w3m`
    - `browsh`?

#### NeoVim flake

Also known as [nvf](https://github.com/NotAShelf/nvf)

- [ ] misc.
  - [x] autoformat is broken
  - [ ] trailing white space character
  - [ ] set spell file
  - [ ] search default to case-insensitive
- [ ] Key binds
  - [ ] `esc` always exits to normal on one press
  - [x] auto-complete
    - [x] `up`/`down` navigate auto-complete suggestions
    - [x] `right` accept suggestion?
  - [ ] surround
    - [ ] from a visual selection (`v` + motion):
      - [ ] `s` to enter surround
        - [ ] `a` to add surrounding character
        - [ ] `r` to replace surrounding characters
  - [ ] fold
    - nvim-ufo?
      - folds all on save
        - likely because of formatting on save
        - set fold level to 0?
- [ ] LuaSnip
  - [ ] add my own snippets _folder_
    - [ ] create some code comment snippets
      - boxed headers
    - [ ] some assignment (markdown) snippets
      - [ ] directory table of contents
      - [ ] assignment details
    - [ ] todo.txt snippets
      - [ ] blank entry
      - [ ] entry w/ deadline
- [ ] REPL (via conjure)
- [ ] `zk`.nvim
