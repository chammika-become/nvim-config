-- map leader to space
-- NOTE : Must happen before plugins are required (wrong leader will be used otherwise)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------
-- better default experience
keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- clear search highlights
keymap.set("n", "<ESC>", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

keymap.set("n", "<leader>q", "<cmd>q<cr>")
keymap.set("n", "<leader>w", "<cmd>w<cr>")
keymap.set("n", "<leader>x", "<cmd>x<cr>")

-- helix goto end of buffer
keymap.set("n", "ge", "GG")

-- window management
-- splits
-- keymap.set("n", "<leader>t\\", "<C-w>v") -- split window vertically (jp kb)
-- keymap.set("n", "<leader>t-", "<C-w>s") -- split window horizontally
-- keymap.set("n", "<leader>t=", "<C-w>=") -- make split windows equal width & height
-- keymap.set("n", "<leader>td", ":close<CR>") -- close current split window

-- tabs
-- keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
-- keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
-- keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
-- keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- quit all windows
keymap.set("n", "<leader>qa", ":qa<CR>")

-- jump to start/end of line in normal mode
keymap.set("n", "H", "^")
keymap.set("n", "L", "$")
