-- unbind space in normal and visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- unbind F1 help
vim.keymap.set('', '<F1>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move lines:
vim.keymap.set({ "n", "v" }, "<A-j>", ":m .+1<CR>==", { noremap = true })
vim.keymap.set({ "n", "v" }, "<A-k>", ":m .-2<CR>==", { noremap = true })
-- for insert mode, exit and reenter insert
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true })

-- Previous and next buffer
vim.keymap.set("n", "<A-h>", ":bp<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-l>", ":bn<CR>", { noremap = true, silent = true })
