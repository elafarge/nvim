return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    local icons = require("core.icons")

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

    mason_tool_installer.setup({
      ensure_installed = {
        "delve",
      },
      auto_update = true,
      run_on_start = true,
    })
  end,
}
