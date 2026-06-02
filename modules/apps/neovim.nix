{inputs, ...}: {
  den.aspects.nvim = {
    nixos = {
      home-manager.sharedModules = [
        inputs.nixvim.homeManagerModules.nixvim
      ];
    };

    homeManager = {pkgs, ...}: {
      programs.nixvim = {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
        viAlias = true;

        dependencies = {
          gcc.enable = true;
        };

        opts = {
          showmode = false;
          cmdheight = 0;
          number = true;
          relativenumber = true;
        };

        extraPackages = [pkgs.alejandra];

        plugins.noice = {
          enable = true;
          settings = {
            presets = {
              bottom_search = true;
              command_palette = true;
              long_message_to_split = true;
            };
          };
        };

        globals.mapleader = " ";

        plugins.indent-blankline = {
          enable = true;
          settings = {
            scope = {
              enabled = false;
            };
          };
        };

        plugins.mini = {
          enable = true;
          modules = {
            indentscope = {
              symbol = "│";
              options = {try_as_border = true;};
              draw = {
                animation = {
                  __raw = "require('mini.indentscope').gen_animation.none()";
                };
              };
            };
          };
        };

        # Core Keymaps
        keymaps = [
          {
            mode = "i";
            key = "jk";
            action = "<Esc>";
            options = {
              desc = "Escape insert mode";
            };
          }
          {
            mode = [
              "n"
              "i"
              "v"
            ];
            key = "<C-s>";
            action = "<cmd>w<cr><esc>";
            options = {
              desc = "Save file";
            };
          }
          {
            mode = "n";
            key = "<leader>e";
            action = "<cmd>Neotree toggle<CR>";
            options = {desc = "Toggle File Explorer";};
          }
          {
            mode = "n";
            key = "<leader><space>";
            action = "<cmd>Telescope find_files<CR>";
            options = {desc = "Find Files";};
          }
          {
            mode = "n";
            key = "<C-h>";
            action = "<C-w>h";
            options = {desc = "Go to left window";};
          }
          {
            mode = "n";
            key = "<C-l>";
            action = "<C-w>l";
            options = {desc = "Go to right window";};
          }
        ];

        colorschemes.catppuccin.enable = true;

        # Statusline
        plugins.lualine = {
          enable = true;
        };

        # Language Servers
        plugins.lsp = {
          enable = true;
          servers = {
            nil_ls.enable = true;
            pyright.enable = true;
            ruff.enable = true;
            rust_analyzer = {
              enable = true;
              installCargo = false;
              installRustc = false;
            };
          };
        };

        # Formatting
        plugins.conform-nvim = {
          enable = true;
          settings = {
            format_on_save = {
              lsp_fallback = true;
              timeout_ms = 500;
            };
            formatters_by_ft = {
              nix = ["alejandra"];
            };
          };
        };

        # Treesitter
        plugins.treesitter = {
          enable = true;
          settings = {
            ensure_installed = [
              "rust"
              "wit"
              "python"
              "nix"
            ];
            highlight = {
              enable = true;
            };
          };
        };

        plugins.neo-tree = {
          enable = true;
          settings = {
            close_if_last_window = true;
            window = {
              mappings = {
                "l" = "open";
                "h" = "close_node";
              };
            };
          };
        };

        # Specific Plugins
        plugins.render-markdown.enable = true;
        plugins.web-devicons.enable = true;
        plugins.telescope.enable = true;
        plugins.which-key.enable = true;
        plugins.gitsigns.enable = true;
      };
    };
  };
}
