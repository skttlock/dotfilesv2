# config (jan 2025)

_Managed with the Nix Home-Manager tool._

> [!NOTE]
> to surpress warning stating that `.../per-user/root/channels` does not exist,
> make said directories.

## To-Do

- [x] restructure
- [ ] update file links per new structure
- [ ] update inputs to... unstable or 24.11
  - [ ] update nixpkgs/NixOS
  - [ ] update home-manager
- [ ] implement flake
  - [ ] test without home-manager
  - [ ] integrate home-manager
  - [ ] test with home-manager
- [ ] check for selective update capability with flake usage
      (`home-manager switch`)

### Configuration

- [ ] `zk` (`~/Documents/Zettle`)
- [ ] `tmux`
  - meh, `zellij` feels a lot nicer
- [ ] `ranger`
- [x] `lsd`

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
