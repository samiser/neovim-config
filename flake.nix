{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nvf,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };

        mkConfig = config:
          nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [config];
          };

        maximalConfig = mkConfig (import ./configuration.nix true);
        minimalConfig = mkConfig (import ./configuration.nix false);
      in {
        packages = {
          default = maximalConfig.neovim;
          minimal = minimalConfig.neovim;
        };
      }
    );
}
