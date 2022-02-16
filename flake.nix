{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, neovim-nightly-overlay, home-manager }:
    let
      system = "x86_64-linux";
    in {
    nixosConfigurations.rocinante = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ({ config, pkgs, ... }: {
          nixpkgs.overlays = [
            (import neovim-nightly-overlay)
          ];
        })
        ./configuration.nix
        ./hosts/rocinante.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.sharad = import ./home/home.nix;
         }
      ];
    };
  };
}
