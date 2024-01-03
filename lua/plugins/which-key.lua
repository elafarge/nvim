return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,

  config = function()
    local whichkey = require("which-key")

    whichkey.setup({
      window = {
        border = "double",
        position = "botton",
      },
      triggers = { "<leader>", "<CR>", "<Semicolon>", ";", ",", "g", "m" },
    })

    local super_mapping_opts = {
      mode = "n", -- Normal mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
    }

    local super_mappings = {
      ["w"] = { "<cmd>update!<CR>", "Save" },
      ["q"] = { "<cmd>q!<CR>", "Quit" },

      f = {
        name = "Find",
        f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
        d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
        b = { "<cmd>Telescope buffers<cr>", "Buffers" },
        o = { "<cmd>Telescope oldfiles<cr>", "Old Files" },
        g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
        c = { "<cmd>Telescope commands<cr>", "Commands" },
        r = { "<cmd>Telescope file_browser<cr>", "Browser" },
        w = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Current Buffer" },
        e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
      },

      l = {
        name = "Code",
        F = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format Document" },
        a = { "<cmd>Telescope lsp_code_actions<CR>", "Code Action" },
        d = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
        r = { "<cmd>Telescope lsp_references<CR>", "References" },
        i = { "<cmd>LspInfo<CR>", "Lsp Info" },
      },
    }

    local goto_mapping_opts = {
      mode = "n", -- Normal mode
      prefix = "<CR>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
    }

    local goto_mappings = {
      name = "LSP",

      a = { "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Code Actions" },
      h = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "Hover documentation" },
      d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
      D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration" },
      s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
      I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
      t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
      R = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto References" },
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    }

    whichkey.register(super_mappings, super_mapping_opts)
    whichkey.register(goto_mappings, goto_mapping_opts)
  end,
}
