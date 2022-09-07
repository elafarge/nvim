local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)
keymap('n', '<F5>', ':NvimTreeToggle<CR>', default_opts)
