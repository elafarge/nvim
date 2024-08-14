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
      win = {
        border = "double",
      },
      -- triggers = {
      --   { "<leader>", mode = "n" },
      --   { "<BSlash>", mode = "n" },
      --   { "<Semicolon>", mode = "n" },
      --   { ";", mode = "n" },
      --   { ",", mode = "n" },
      --   { "g", mode = "n" },
      --   { "m", mode = "n" },
      -- },
    })

    local super_mapping_opts = nil

    local super_mappings = {
      { "<leader>f", group = "Find", nowait = false, remap = false },
      {
        "<leader>fb",
        "<cmd>Telescope buffers<cr>",
        desc = "Buffers",
        nowait = false,
        prefix = "<leader>",
        remap = false,
        silent = true,
      },
      {
        "<leader>fc",
        "<cmd>Telescope commands<cr>",
        desc = "Commands",
        nowait = false,
        remap = false,
        silent = true,
        prefix = "<leader>",
      },
      {
        "<leader>fe",
        "<cmd>NvimTreeToggle<cr>",
        desc = "Explorer",
        nowait = false,
        remap = false,
        silent = true,
        prefix = "<leader>",
      },
      {
        "<leader>ff",
        "<cmd>Telescope find_files<cr>",
        desc = "Files",
        nowait = false,
        remap = false,
        silent = true,
        prefix = "<leader>",
      },
      {
        "<leader>fg",
        "<cmd>Telescope live_grep<cr>",
        desc = "Live Grep",
        nowait = false,
        remap = false,
        prefix = "<leader>",
        silent = true,
      },
      {
        "<leader>fo",
        "<cmd>Telescope oldfiles<cr>",
        desc = "Old Files",
        nowait = false,
        remap = false,
        silent = true,
        prefix = "<leader>",
      },
      {
        "<leader>fr",
        "<cmd>Telescope file_browser<cr>",
        desc = "Browser",
        nowait = false,
        remap = false,
        silent = true,
        prefix = "<leader>",
      },
      {
        "<leader>fw",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Current Buffer",
        nowait = false,
        remap = false,
        prefix = "<leader>",
        silent = true,
      },
      { "<leader>l", group = "Code", nowait = false, remap = false },
      {
        "<leader>lF",
        "<cmd>lua vim.lsp.buf.format()<CR>",
        desc = "Format Document",
        nowait = false,
        remap = false,
        prefix = "<leader>",
        silent = true,
      },
      {
        "<leader>la",
        "<cmd>Telescope lsp_code_actions<CR>",
        desc = "Code Action",
        nowait = false,
        remap = false,
        prefix = "<leader>",
        silent = true,
      },
      {
        "<leader>ld",
        "<cmd>Telescope diagnostics<CR>",
        desc = "Diagnostics",
        nowait = false,
        prefix = "<leader>",
        remap = false,
        silent = true,
      },
      {
        "<leader>li",
        "<cmd>LspInfo<CR>",
        desc = "Lsp Info",
        nowait = false,
        remap = false,
        prefix = "<leader>",
        silent = true,
      },
      {
        "<leader>lr",
        "<cmd>Telescope lsp_references<CR>",
        desc = "References",
        nowait = false,
        prefix = "<leader>",
        remap = false,
        silent = true,
      },
      {
        "<leader>q",
        "<cmd>q!<CR>",
        desc = "Quit",
        nowait = false,
        remap = false,
        prefix = "<leader>",
        silent = true,
      },
      {
        "<leader>w",
        "<cmd>update!<CR>",
        desc = "Save",
        nowait = false,
        remap = false,
        prefix = "<leader>",
        silent = true,
      },
    }

    local goto_mapping_opts = {
      mode = "n", -- Normal mode
      prefix = "<BSlash>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = false, -- use `nowait` when creating keymaps
    }

    local goto_mappings = {
      { "<BSlash>", group = "LSP", nowait = false, remap = false },
      {
        "<BSlash>D",
        "<Cmd>lua vim.lsp.buf.declaration()<CR>",
        desc = "Goto Declaration",
        nowait = false,
        remap = false,
      },
      {
        "<BSlash>I",
        "<cmd>lua vim.lsp.buf.implementation()<CR>",
        desc = "Goto Implementation",
        nowait = false,
        remap = false,
      },
      {
        "<BSlash>R",
        "<cmd>lua vim.lsp.buf.references()<CR>",
        desc = "Goto References",
        nowait = false,
        remap = false,
      },
      {
        "<BSlash>a",
        "<Cmd>lua vim.lsp.buf.code_action()<CR>",
        desc = "Code Actions",
        nowait = false,
        remap = false,
      },
      {
        "<BSlash>d",
        "<Cmd>lua vim.lsp.buf.definition()<CR>",
        desc = "Goto Definition",
        nowait = false,
        remap = false,
      },
      {
        "<BSlash>h",
        "<Cmd>lua vim.lsp.buf.hover()<CR>",
        desc = "Hover documentation",
        nowait = false,
        remap = false,
      },
      {
        "<BSlash>r",
        "<cmd>lua vim.lsp.buf.rename()<CR>",
        desc = "Rename",
        nowait = false,
        remap = false,
      },
      {
        "<BSlash>s",
        "<cmd>lua vim.lsp.buf.signature_help()<CR>",
        desc = "Signature Help",
        nowait = false,
        remap = false,
      },
      {
        "<BSlash>t",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        desc = "Goto Type Definition",
        nowait = false,
        remap = false,
      },
    }

    whichkey.add(super_mappings)
    whichkey.add(goto_mappings)
  end,
}
