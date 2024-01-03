return {
  "zbirenbaum/copilot.lua",
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
