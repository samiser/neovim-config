maximal:
{ lib, pkgs, ... }:
let
  mkFlakeConfigOptions = output: ''
    let
      cfgs = (builtins.getFlake (builtins.toString ./.)).${output};
    in
    cfgs.''${builtins.head (builtins.attrNames cfgs)}.options
  '';
in
{
  config.vim = {
    languages.nix.lsp.servers = [ "nixd" ];

    lsp.servers = lib.mkIf maximal {
      nixd.settings.nixd = {
        nixpkgs.expr = ''
          let
            root = builtins.toString ./.;
          in
          if builtins.pathExists (root + "/pkgs/top-level/all-packages.nix") then
            import root { }
          else
            import ${pkgs.path} { }
        '';

        options = {
          nvf.expr = ''
            ((builtins.getFlake (builtins.toString ./.)).inputs.nvf.lib.neovimConfiguration {
              pkgs = import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs {
                system = builtins.currentSystem;
              };
            }).options
          '';

          flake-nixos.expr = mkFlakeConfigOptions "nixosConfigurations";
          flake-darwin.expr = mkFlakeConfigOptions "darwinConfigurations";
          flake-home-manager.expr = mkFlakeConfigOptions "homeConfigurations";
        };
      };
    };
  };
}
