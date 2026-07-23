maximal: {lib, ...}: {
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
      # nix formatting is configured manually below so it can follow the
      # repo's own `nix fmt` formatter when one is available
      nix.format.enable = false;
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

    formatter.conform-nvim = {
      enable = maximal;
      presets.nixfmt.enable = maximal;
      setupOpts = {
        # runs the repo's own formatter (e.g. nixfmt-rfc-style in nixpkgs);
        # stdin = false makes conform pass a temp file next to the real one
        formatters.nix_fmt = {
          command = "nix";
          args = ["fmt" "--" "$FILENAME"];
          stdin = false;
          cwd = lib.generators.mkLuaInline ''require("conform.util").root_file({"flake.nix"})'';
          require_cwd = true;
        };

        # use `nix fmt` in flake repos that declare a formatter output,
        # otherwise fall back to nixfmt
        formatters_by_ft.nix = lib.generators.mkLuaInline ''
          (function()
            local cache = {}
            return function(bufnr)
              local root = vim.fs.root(bufnr, "flake.nix")
              if not root then
                return { "nixfmt" }
              end
              if cache[root] == nil then
                local ok, lines = pcall(vim.fn.readfile, root .. "/flake.nix")
                cache[root] = ok
                  and table.concat(lines, "\n"):find("formatter", 1, true) ~= nil
              end
              return cache[root] and { "nix_fmt" } or { "nixfmt" }
            end
          end)()
        '';

        # same gating as the nvf default, but with a longer timeout since
        # `nix fmt` has to evaluate the flake's formatter (~1-2s in nixpkgs)
        format_on_save = lib.generators.mkLuaInline ''
          function()
            if not vim.g.formatsave or vim.b.disableFormatSave then
              return
            else
              return { lsp_format = "fallback", timeout_ms = 3000 }
            end
          end
        '';
      };
    };

    luaConfigPost = builtins.readFile ./keymaps.lua;
  };
}
