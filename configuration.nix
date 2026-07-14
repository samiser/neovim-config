maximal: {
  config.vim = {
    viAlias = true;
    vimAlias = true;

    options = {
      tabstop = 2;
      shiftwidth = 2;
    };

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
      # cpplint tests fail on python 3.14 (codecs.open DeprecationWarning)
      clang.extraDiagnostics.enable = false;
      css.enable = maximal;
      html.enable = maximal;
      lua.enable = maximal;
      # tracking https://github.com/NixOS/nixpkgs/issues/483584
      #markdown.enable = maximal;
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
        # catppuccin renamed its lualine theme to `catppuccin-nvim`, which
        # nvf's theme enum doesn't know about yet; set it via setupOpts
        setupOpts.options.theme = "catppuccin-nvim";
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
      fastaction = {
        enable = maximal;
        setupOpts.register_ui_select = false;
      };
    };

    comments = {
      comment-nvim.enable = maximal;
    };

    luaConfigPost = builtins.readFile ./keymaps.lua;
  };
}
