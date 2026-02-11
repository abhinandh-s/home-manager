{
  description = "Home Manager configuration of abhi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-fonts = {
      url = "github:abhinandh-s/nix-fonts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
      nix-scripts = {
      url = "path:/home/abhi/git/nix-scripts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }:
    let
      system = "x86_64-linux";
      overlays = [
      (import inputs.rust-overlay)
      inputs.nix-scripts.overlays.default
      (final: prev: {
        unstable = import inputs.unstable-nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      })
    ];
    pkgs = import nixpkgs {
      inherit system overlays;
    };
    in
    {
      homeConfigurations = {
      abhi = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
            ./home.nix
            inputs.sops-nix.homeManagerModules.sops
          ];
        extraSpecialArgs = {
            performFullSetup = true;
          inherit inputs;
          userSettings = {
            name = "abhi";
            email = {
              personal = "abhinandhsuby@proton.me";
              professional = "abhinandhs@hotmail.com";
              dev = "ugabhi@proton.me";
            };
          };
        };
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
      };
    };
}
