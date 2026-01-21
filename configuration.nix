maximal: {
  config.vim = {
    viAlias = true;
    vimAlias = true;

    lsp = {
      enable = maximal;
      formatOnSave = maximal;
      lightbulb.enable = maximal;
      trouble.enable = maximal;
      lspSignature.enable = maximal;
    };

    utility = {
      surround.enable = maximal;
      motion.flash-nvim.enable = true;
    };

    languages = {
      enableFormat = maximal;
      enableTreesitter = maximal;
      enableExtraDiagnostics = maximal;

      bash.enable = maximal;
      clang.enable = maximal;
      css.enable = maximal;
      html.enable = maximal;
      lua.enable = maximal;
      markdown.enable = maximal;
      nix.enable = maximal;
      python.enable = maximal;
      svelte.enable = maximal;
      zig.enable = maximal;
    };

    visuals = {
      nvim-scrollbar.enable = maximal;
      nvim-web-devicons.enable = true;
      nvim-cursorline.enable = maximal;
      cinnamon-nvim.enable = maximal;
      fidget-nvim.enable = maximal;

      highlight-undo.enable = maximal;
      indent-blankline.enable = maximal;
    };

    statusline = {
      lualine = {
        enable = maximal;
        theme = "catppuccin";
      };
    };

    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = true;
    };

    autopairs.nvim-autopairs.enable = maximal;

    autocomplete.nvim-cmp.enable = maximal;
    snippets.luasnip.enable = maximal;

    filetree = {
      neo-tree = {
        enable = maximal;
      };
    };

    tabline = {
      nvimBufferline = {
        enable = true;
        mappings = {
          cycleNext = "<C-N>";
          cyclePrevious = "<C-P>";
        };
      };
    };

    binds = {
      whichKey.enable = maximal;
    };

    telescope.enable = maximal;

    git = {
      enable = maximal;
      gitsigns.enable = maximal;
    };

    dashboard = {
      dashboard-nvim.enable = maximal;
      alpha.enable = maximal;
    };

    notify = {
      nvim-notify.enable = maximal;
    };

    projects = {
      project-nvim.enable = maximal;
    };

    terminal = {
      toggleterm = {
        enable = maximal;
        lazygit.enable = maximal;
      };
    };

    ui = {
      borders.enable = maximal;
      noice.enable = maximal;
      colorizer.enable = maximal;
      illuminate.enable = maximal;
      fastaction.enable = maximal;
    };

    comments = {
      comment-nvim.enable = maximal;
    };

    luaConfigPost = builtins.readFile ./keymaps.lua;
  };
}
