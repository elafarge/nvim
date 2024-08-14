return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")
    local api = require("nvim-tree..api")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    -- configure nvim-tree
    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = false,
        number = true,
      },
      -- change folder arrow icons
      renderer = {
        add_trailing = true,
        highlight_opened_files = "icon",
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      actions = {
        open_file = {
          resize_window = false,
          window_picker = {
            enable = true,
          },
        },
      },
      update_focused_file = {
        enable = true,
        update_cwd = false,
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
      tab = {
        sync = {
          open = true,
          close = false,
        },
      },
      -- Set keybindings, only for the nvim-tree buffer of course
      on_attach = function(bufnr)
        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        keymap.set("n", "<F5>", ":NvimTreeToggle<CR>", opts("Toggle Nvim Tree"))

        -- keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
        -- keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
        -- keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
        -- keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
        -- keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
        -- keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
        -- keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
        -- keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
        -- keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        -- keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
        -- keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
        -- keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
        -- keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
        -- keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
        -- keymap.set('n', 'a', api.fs.create, opts('Create'))
        -- keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
        -- keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
        -- keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
        -- keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
        -- keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
        -- keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
        -- keymap.set('n', 'd', api.fs.remove, opts('Delete'))
        -- keymap.set('n', 'D', api.fs.trash, opts('Trash'))
        -- keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
        -- keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
        -- keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
        -- keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
        -- keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
        -- keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
        -- keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
        -- keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
        -- keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
        -- keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
        -- keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
        -- keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
        -- keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
        -- keymap.set('n', 'o', api.node.open.edit, opts('Open'))
        -- keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
        -- keymap.set('n', 'p', api.fs.paste, opts('Paste'))
        -- keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
        -- keymap.set('n', 'q', api.tree.close, opts('Close'))
        -- keymap.set('n', 'r', api.fs.rename, opts('Rename'))
        -- keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
        -- keymap.set('n', 's', api.node.run.system, opts('Run System'))
        -- keymap.set('n', 'S', api.tree.search_node, opts('Search'))
        -- keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
        -- keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
        -- keymap.set('n', 'x', api.fs.cut, opts('Cut'))
        -- keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
        -- keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
        -- keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
        -- keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
        -- END_DEFAULT_ON_ATTACH

        -- Mappings migrated from view.mappings.list
        keymap.set("n", "<CR>", api.node.open.no_window_picker, opts("Open: No Window Picker"))
        keymap.set("n", "<2-Leftmouse>", api.node.open.no_window_picker, opts("Open: No Window Picker"))
        keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
        keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
        keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
        keymap.set("n", "a", api.fs.create, opts("Create"))
        keymap.set("n", "d", api.fs.remove, opts("Delete"))
        keymap.set("n", "r", api.fs.rename, opts("Rename"))
        keymap.set("n", "x", api.fs.cut, opts("Cut"))
        keymap.set("n", "y", api.fs.copy.node, opts("Copy"))
        keymap.set("n", "p", api.fs.paste, opts("Paste"))
        keymap.set("n", "c", api.tree.change_root_to_node, opts("CD"))
      end,
    })
  end,
}
