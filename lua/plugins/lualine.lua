local function lsp_client(msg)
  msg = msg or ""
  local buf_clients = vim.lsp.get_clients()
  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return ""
    end
    return msg
  end

  local buf_client_names = {}

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= "none-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  -- TODO: add formatters, linters, etc
  -- -- add formatter
  -- local formatters = require "config.lsp.null-ls.formatters"
  -- local supported_formatters = formatters.list_registered(buf_ft)
  -- vim.list_extend(buf_client_names, supported_formatters)

  -- -- add linter
  -- local linters = require "config.lsp.null-ls.linters"
  -- local supported_linters = linters.list_registered(buf_ft)
  -- vim.list_extend(buf_client_names, supported_linters)

  -- -- add hover
  -- local hovers = require "config.lsp.null-ls.hovers"
  -- local supported_hovers = hovers.list_registered(buf_ft)
  -- vim.list_extend(buf_client_names, supported_hovers)

  return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

local function lsp_status(_, is_active)
  if not is_active then
    return ""
  end
  require("lsp-progress").progress()
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          { "filename", path = 1 },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { lsp_client, icon = " " },
          { lsp_status },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
