return {
  "williamboman/mason.nvim",
  dependencies = {
    -- Detect the helm filetype and use Helm LS for it
    "towolf/vim-helm",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local icons = require("core.icons")

    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = cmp_nvim_lsp.default_capabilities()

    mason.setup({
      ui = {
        icons = {
          package_installed = icons.server_installed,
          package_pending = icons.server_pending,
          package_uninstalled = icons.server_uninstalled,
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "bashls",
        "gopls",
        "helm_ls",
        "html",
        "jsonls",
        "lua_ls",
        "omnisharp",
        "pylsp",
        "terraformls",
        "tsserver",
        "vimls",
        "yamlls",
      },

      automatic_installation = true,
    })

    -- Change diagnostic icons
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({})
      end,

      ["omnisharp"] = function()
        lspconfig["omnisharp"].setup({
          capabilities = capabilities,
          on_attach = function(client, _)
            local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
            for i, v in ipairs(tokenModifiers) do
              tokenModifiers[i] = v:gsub(" ", "_"):gsub("-_", "")
            end
            local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
            for i, v in ipairs(tokenTypes) do
              tokenTypes[i] = v:gsub(" ", "_"):gsub("-_", "")
            end
            client.server_capabilities.semanticTokensProvider.legend.tokenModifiers = tokenModifiers
            client.server_capabilities.semanticTokensProvider.legend.tokenTypes = tokenTypes
          end,
        })
      end,

      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                -- make language server aware of runtime files
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
                },
              },
            },
          },
        })
      end,

      ["yamlls"] = function()
        lspconfig["yamlls"].setup({
          capabilities = capabilities,
          on_attach = function(_, bufnr)
            -- Disable YAMLLS diagnostics for Helm files
            if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
              local client = vim.lsp.get_active_clients({ name = "yamlls" })[1]
              local ns = vim.lsp.diagnostic.get_namespace(client.id)
              vim.diagnostic.disable(bufnr, ns)
            end
          end,
        })
      end,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "delve",
      },
      auto_update = true,
      run_on_start = true,
    })
  end,
}
