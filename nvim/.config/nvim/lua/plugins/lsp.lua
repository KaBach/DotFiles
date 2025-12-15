return {

  -- LSP features for code cells / embedded code
  {
    "jmbuhr/otter.nvim",
    dev = false,
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      buffers = {
        set_filetype = true,
        write_to_disk = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      {
        -- nice loading notifications (optional)
        -- PERF: can slow down startup
        "j-hui/fidget.nvim",
        enabled = false,
        opts = {},
      },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            -- add libraries here that provide Lua types for completion
            -- examples:
            -- "neovim/nvim-lspconfig",
            -- "nvim-lua/plenary.nvim",
          },
        },
      },
    },

    config = function()
      -----------------------------------------------------------------------
      -- Utilities
      -----------------------------------------------------------------------
      local util = require("lspconfig.util")

      -----------------------------------------------------------------------
      -- Mason setup
      -----------------------------------------------------------------------
      require("mason").setup()
      require("mason-lspconfig").setup {
        automatic_installation = true,
        ensure_installed = {
          "bashls",
          "cssls",
          "html",
          "jsonls",
          "lua_ls",
          "marksman",
          "pyright",
          "r_language_server",
          "yamlls",
          "julials",
        },
      }
      require("mason-tool-installer").setup {
        ensure_installed = {
          "black",
          "stylua",
          "shfmt",
          "isort",
          --"tree-sitter-cli",
          "jupytext",
        },
      }

      -----------------------------------------------------------------------
      -- LspAttach keymaps
      -----------------------------------------------------------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local function map(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          local function vmap(keys, func, desc)
            vim.keymap.set("v", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          assert(client, "LSP client not found")

          ---@diagnostic disable-next-line: inject-field
          client.server_capabilities.document_formatting = true

          map("gS", vim.lsp.buf.document_symbol, "[g]o symbols")
          map("gD", vim.lsp.buf.type_definition, "[g]o type [D]efinition")
          map("gd", vim.lsp.buf.definition, "[g]o [d]efinition")
          map("K", vim.lsp.buf.hover, "[K] hover")
          map("gh", vim.lsp.buf.signature_help, "[g] signature [h]elp")
          map("gI", vim.lsp.buf.implementation, "[g]o to [I]mplementation")
          map("gr", vim.lsp.buf.references, "[g]o [r]eferences")
          map("[d", vim.diagnostic.goto_prev, "previous diagnostic")
          map("]d", vim.diagnostic.goto_next, "next diagnostic")
          map("<leader>ll", vim.lsp.codelens.run, "[l]ens run")
          map("<leader>lR", vim.lsp.buf.rename, "[l]sp [R]ename")
          map("<leader>lf", vim.lsp.buf.format, "[l]sp [f]ormat")
          vmap("<leader>lf", vim.lsp.buf.format, "[l]sp [f]ormat")
          map("<leader>lq", vim.diagnostic.setqflist, "diagnostics to quickfix")
        end,
      })

      -----------------------------------------------------------------------
      -- Handlers and capabilities
      -----------------------------------------------------------------------
      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = require("misc.style").border })
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = require("misc.style").border })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- avoid too many watchers (pyright + Neovim issue)
--      capabilities.workspace = capabilities.workspace or {}
--      capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = false }

      -----------------------------------------------------------------------
      -- SERVER CONFIGS (NEW API: vim.lsp.config + vim.lsp.enable)
      -----------------------------------------------------------------------

      -- MARKSMAN ------------------------------------------------------------
      -- also needs:
      -- $home/.config/marksman/config.toml :
      -- [core]
      -- markdown.file_extensions = ["md", "markdown", "qmd"]
      vim.lsp.config("marksman", {
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { "markdown", "quarto" },
        root_dir = util.root_pattern(
          ".git",
          ".marksman.toml",
          "_quarto.yml"
        ),
      })
      vim.lsp.enable("marksman")

      -- LUA LS --------------------------------------------------------------
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              disable = { "trailing-space" },
            },
            workspace = {
              checkThirdParty = false,
            },
            doc = {
              privateName = { "^_" },
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- JULIA LS ------------------------------------------------------------
      vim.lsp.config("julials", {
        capabilities = capabilities,
        flags = lsp_flags,
      })
      vim.lsp.enable("julials")

      -- BASH LS -------------------------------------------------------------
      vim.lsp.config("bashls", {
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { "sh", "bash" },
      })
      vim.lsp.enable("bashls")

      -- R LS -------------------------------------------------------------
      vim.lsp.config("r_language_server", {
        filetypes = { "r", "rmd", "rmarkdwon" },
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          r = {
            lsp = {
              rich_documentation = false
            },
          },
        },
      })
      vim.lsp.enable("r_language_server")

      -- Yaml LS -------------------------------------------------------------
      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        flags = lsp_flags,
         settings = {
          yaml = {
            schemaStore = {
              enable = true,
              url = '',
            },
          },
        },
      })
      vim.lsp.enable("yamlls")

      -- CSS LS -------------------------------------------------------------
      vim.lsp.config("cssls", {
        capabilities = capabilities,
        flags = lsp_flags,
      })
      vim.lsp.enable("cssls")

      -- JSON LS -------------------------------------------------------------
      vim.lsp.config("jsonls", {
        capabilities = capabilities,
        flags = lsp_flags,
      })
      vim.lsp.enable("jsonls")

      -- PYRIGHT -------------------------------------------------------------
      -- See https://github.com/neovim/neovim/issues/23291
      -- disable lsp watcher.
      -- Too lags on linux for python projects
      -- because pyright and nvim both create too many watchers otherwise
      if capabilities.workspace == nil then
        capabilities.workspace = {}
        capabilities.workspace.didChangeWatchedFiles = {}
      end
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
        root_dir = function(fname)
          return util.root_pattern(
            ".git",
            "setup.py",
            "setup.cfg",
            "pyproject.toml",
            "requirements.txt"
          )(fname) or util.path.dirname(fname)
        end,
      })
      vim.lsp.enable("pyright")
    end,
  },
}

