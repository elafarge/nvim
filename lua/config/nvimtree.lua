local M = {}

function M.setup()
  require("nvim-tree").setup {
    disable_netrw = true,
    hijack_netrw = true,
    update_focused_file = {
      enable = true
    },
    renderer = {
      add_trailing = true,
      highlight_opened_files = "icon",
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    view = {
      number = true,
      relativenumber = true,
      mappings = {
        list = {
          -- Edit directly
          { key = { "<CR>", "<2-Leftmouse>" }, action = "edit_no_picker", mode = "n" },

          -- Edit in a split/tab
          { key = "s", action = "split", mode = "n" },
          { key = "v", action = "vsplit", mode = "n" },
          { key = "t", action = "tabnew", mode = "n" },

          -- Add/remove/rename/copy/paste files
          { key = "a", action = "create", mode = "n" },
          { key = "d", action = "remove", mode = "n" },
          { key = "r", action = "rename", mode = "n" },
          { key = "x", action = "cut", mode = "n" },
          { key = "y", action = "copy", mode = "n" },
          { key = "p", action = "paste", mode = "n" },
        }
      },
    },
    filters = {
      custom = { ".git" },
    },
  }
end

return M
