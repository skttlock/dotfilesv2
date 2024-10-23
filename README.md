# config (oct 2024)
*Managed with the Nix Home-Manager tool.*

*note* to surpress warning stating that `xyz/per-user/root/channels` does not exist, make said directories.

## To-Do
- [ ] `./configuration.nix`
    - [ ] generate via nix command
    - [ ] symlink via home-manager
    - [ ]
- [ ] gittemplate
- [ ] tiling + layouts
    - sway?
        - login manager:
        - "no diplay manager needed"
        - input configuration...
        - wallpapers: swaybg
            - `output HDMI-A-1 bg ~/wallpaper.png stretch` <- example
        - bar: waybar ~~swaybar~~
        - screenshots: flameshot
        - program launcher: tofi?
        - config:
            - appearance:
                - color: solarized?
                - darkmode: darkman
                - fonts:
                - gaps: small
            - layouts/workspaces:
                - notes
                    - window, horizontal split right, stacked: obsidian vaults
                    -
                - code
                    - window, horizontal split: terminal
                    -
                - browse
                    - window, horizontal split: firefox
                - game
        - other plugins:
            - wlr-which-key
            - swaylock
            - swayidle
            - swaync
            - swayosd


    - [ ] define some layouts:
        - school
        - work
        - play
- [ ] sops-nix
    - ssh keys
- [/] nixvim plugins
    - [ ] snippets
    - [/] startup time
    - [ ] lazyload
    - [/] better lsp config (lazyload, etc.)
        - [ ] jdtls needs keybind or delay
    - [x] mini nvim
        - [ ] mini.darmo idea
    - [ ] 

- [ ] modularize??
    - [ ] learn how
    - [ ] /modules/nixvim.nix
- [ ] configure less
- [ ] stylix?
    - note:
        - vim cursor color changes when over a character with foreground-color or somethin
- [ ] scripts
    - [ ] back up scripts
        - --local
        - --cloud
        - --external
        - --fromPath    ?
        - --toPath      ?
