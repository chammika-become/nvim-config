-- plugin keymaps
local keymap = vim.keymap -- for conciseness

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- FloatingTerm
keymap.set("n", "t", '<CMD>lua require("FTerm").toggle()<CR>')
keymap.set("t", "<Esc>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- nvim-tree toggle
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- hop (easymotion)
keymap.set("n", "f", ":HopChar1<CR>")
