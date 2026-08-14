{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nvf,
      systems,
      ...
    }:
    let
      eachSystem =
        f:
        nixpkgs.lib.genAttrs (import systems) (
          system:
          f (
            import nixpkgs {
              inherit system;
            }
          )
        );
    in
    {
      packages = eachSystem (
        pkgs:
        let
          mkConfig =
            config:
            nvf.lib.neovimConfiguration {
              inherit pkgs;
              modules = [ config ];
            };

          maximalConfig = mkConfig (import ./configuration.nix true);
          minimalConfig = mkConfig (import ./configuration.nix false);
        in
        {
          default = maximalConfig.neovim;
          minimal = minimalConfig.neovim;
        }
      );
    };
}
