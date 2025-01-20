{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nvf = {
            url = "github:notashelf/nvf";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs @ {
        self,
        nixpkgs,
        nvf,
        home-manager,
        ...
        }: {
            nixosConfigurations = {
                nixos = nixpkgs.lib.nixosSystem { # note, "nixos" here is the hostname
                    system = "x86_64-linux";
                    modules = [
                        ./systems/laptop/configuration.nix
                        nvf.nixosModules.default
                        home-manager.nixosModules.home-manager
                        {
                            home-manager = {
                                useGlobalPkgs = true;
                                useUserPackages = true;
                                users.joshuaf = import ./modules/home-manager/home.nix;
                            };
                        }
                    ];
                };
            };
        };
}
