local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- Moving across and resizing panes
keymap("n", "<S-h>", ":wincmd h<CR>", { noremap = true })
keymap("n", "<S-j>", ":wincmd j<CR>", { noremap = true })
keymap("n", "<S-k>", ":wincmd k<CR>", { noremap = true })
keymap("n", "<S-l>", ":wincmd l<CR>", { noremap = true })

keymap("n", "<C-l>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<C-h>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<C-k>", ":resize -1<CR>", default_opts)
keymap("n", "<C-j>", ":resize +1<CR>", default_opts)
keymap("n", "<C-L>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<C-H>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<C-K>", ":resize -1<CR>", default_opts)
keymap("n", "<C-J>", ":resize +1<CR>", default_opts)
keymap("n", "<F5>", ":NvimTreeToggle<CR>", default_opts)

-- keymap('n', ';', ':HopWord<CR>', default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)
