return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false }, -- interferes with copilot CMP completion
      panel = { enabled = false }, -- interferes with copilot CMP completion
      filetypes = {
        yaml = true,
      },
    })
  end,
}
