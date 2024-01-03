return {
  "catppuccin/nvim",
  priority = 1000,
  config = function()
    vim.cmd([[set background=dark]])
    vim.cmd([[colorscheme catppuccin-frappe]])
  end,
}
