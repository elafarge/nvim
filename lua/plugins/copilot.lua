return {
  "zbirenbaum/copilot.lua",
  dependencies = {
    -- Use Copilot as a CMP completion source
    "zbirenbaum/copilot-cmp",
  },
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = true },
      panel = { enabled = true, auto_refresh = true },
      filetypes = {
        yaml = true,
      },
    })
  end,
}
