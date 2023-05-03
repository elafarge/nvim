local M = {}

function M.setup(servers, options)
  local lspconfig = require "lspconfig"
  local icons = require "config.icons"

  require("mason").setup {
    ui = {
      icons = {
        package_installed = icons.server_installed,
        package_pending = icons.server_pending,
        package_uninstalled = icons.server_uninstalled,
      },
    },
  }

  require("mason-tool-installer").setup {
    ensure_installed = { "stylua", "shfmt", "shellcheck", "omnisharp", "prettierd" },
    auto_update = true,
    run_on_start = true,
  }

  require("mason-lspconfig").setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = true,
  }

  -- Package installation folder
  local install_root_dir = vim.fn.stdpath "data" .. "/mason"

  require("mason-lspconfig").setup_handlers {
    function(server_name)
      -- TODO(etienne): seems likes this overrides on attach, see how we could override it better maybe
      local opts = vim.tbl_deep_extend("force", options, servers[server_name] or {})
      lspconfig[server_name].setup { opts }
    end,
    ["jdtls"] = function()
      -- print "jdtls is handled by nvim-jdtls"
    end,
    -- ["csharp_ls"] = function()
    --   lspconfig.csharp_ls.setup({
    --     settings = {
    --       csharp = {
    --         solution = "/home/etienne/Code/gopigment/monorepo/apps/all.sln"
    --       }
    --     }
    --   })
    -- end,
    ["omnisharp"] = function()
      lspconfig.omnisharp.setup({
        on_attach = function(client, bufnr)
          local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
          for i, v in ipairs(tokenModifiers) do
            tokenModifiers[i] = v:gsub(' ', '_'):gsub('-_', '')
          end
          local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
          for i, v in ipairs(tokenTypes) do
            tokenTypes[i] = v:gsub(' ', '_'):gsub('-_', '')
          end
          client.server_capabilities.semanticTokensProvider.legend.tokenModifiers = tokenModifiers
          client.server_capabilities.semanticTokensProvider.legend.tokenTypes = tokenTypes

          -- TODO etienne: remove repetition from installer.lua
          -- Enable completion triggered by <C-X><C-O>
          -- See `:help omnifunc` and `:help ins-completion` for more information.
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

          -- Use LSP as the handler for formatexpr.
          -- See `:help formatexpr` for more information.
          vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

          -- Configure key mappings
          require("config.lsp.keymaps").setup(client, bufnr)

          -- Configure highlighting
          require("config.lsp.highlighting").setup(client)

          -- Configure formatting
          require("config.lsp.null-ls.formatters").setup(client, bufnr)
        end
      })
    end,
    ["lua_ls"] = function()
      local opts = vim.tbl_deep_extend("force", options, servers["lua_ls"] or {})
      lspconfig.lua_ls.setup(opts)
    end,
    ["tsserver"] = function()
      local opts = vim.tbl_deep_extend("force", options, servers["tsserver"] or {})
      require("typescript").setup {
        disable_commands = false,
        debug = false,
        server = opts,
      }
    end,
    ["yamlls"] = function()
      lspconfig.yamlls.setup({
        settings = {
          yaml = {
            keyOrdering = false,
          },
        },
      })
    end,
  }
end

return M
