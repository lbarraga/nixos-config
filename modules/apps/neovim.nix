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
          pumheight = 5; # Limits the autocomplete menu item amount

          undofile = true;

          # Indentation settings
          autoindent = true;
          smartindent = true;
          expandtab = true; # Uses spaces instead of tabs
          shiftwidth = 2; # Sets the number of spaces per indent
          tabstop = 2; # Sets how many spaces a tab character represents
        };

        diagnostics = {
          virtual_text = {
            prefix = "●";
            spacing = 4;
          };
          signs = true;
          underline = true;
          severity_sort = true;
        };

        extraConfigLua = ''
          vim.api.nvim_create_autocmd("TextYankPost", {
            desc = "Highlight when yanking (copying) text",
            callback = function()
              vim.highlight.on_yank({ timeout = 200 })
            end,
          })
        '';

        extraPackages = [pkgs.alejandra];

        globals.mapleader = " ";

        # use system clipboard
        clipboard = {
          register = "unnamedplus";
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
          {
            mode = "n";
            key = "<leader>ca";
            action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
            options = {desc = "Code Action";};
          }
          {
            mode = "n";
            key = "<leader>cd";
            action = "<cmd>lua vim.diagnostic.open_float()<cr>";
            options = {desc = "Line Diagnostics";};
          }
          {
            mode = "n";
            key = "qq";
            action = "<cmd>qa<cr>";
            options = {desc = "Quit all";};
          }
        ];

        colorschemes.catppuccin.enable = true;

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
              settings = {
                check = {
                  command = "clippy";
                };
              };
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

        plugins.cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            window = {
              completion = {border = "rounded";};
              documentation = {border = "rounded";};
            };
            sources = [
              {name = "nvim_lsp";} # Code completions pulled from lsp
              {name = "path";} # code completions for typing directories
            ];
            mapping = {
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-e>" = "cmp.mapping.abort()";
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

        plugins.dressing = {
          enable = true;
          settings = {
            select = {
              backend = ["builtin"];
              builtin = {
                relative = "cursor";
              };
            };
          };
        };

        # Specific Plugins
        plugins.web-devicons.enable = true;
        plugins.telescope.enable = true;
        plugins.which-key.enable = true;
        plugins.gitsigns.enable = true;
      };
    };
  };
}
