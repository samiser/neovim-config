maximal:
{ lib, pkgs, ... }:
{
  config.vim = lib.mkIf maximal {
    treesitter.grammars = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [
      gdscript
      gdshader
      godot_resource
    ];

    lsp.servers.gdscript = {
      cmd = lib.generators.mkLuaInline "vim.lsp.rpc.connect('127.0.0.1', 6005)";
      filetypes = [ "gdscript" ];
      root_markers = [ "project.godot" ];
    };

    formatter.conform-nvim.setupOpts = {
      formatters.gdformat.command = lib.getExe' pkgs.gdtoolkit_4 "gdformat";
      formatters_by_ft.gdscript = [ "gdformat" ];
    };

    diagnostics.nvim-lint = {
      enable = true;
      linters.gdlint.cmd = lib.getExe' pkgs.gdtoolkit_4 "gdlint";
      linters_by_ft.gdscript = [ "gdlint" ];
    };
  };
}
