return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local on_attach = function(_, _)
      -- called for all LSPs
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change diagnostic icons
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- LSP server configurations
    lspconfig["omnisharp"].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)

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

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
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

    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["gopls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["helm_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["jsonls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["pylsp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["terraformls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["vimls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["yamlls"].setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        -- Disable diagnostics for Helm files
        if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
          vim.diagnostic.disable(bufnr)
          vim.defer_fn(function()
            vim.diagnostic.reset(nil, bufnr)
          end, 1000)
        end
      end,
    })
  end,
}
