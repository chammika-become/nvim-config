-- plugin keymaps
local keymap = vim.keymap -- for conciseness

-- FloatingTerm
keymap.set("n", "<leader>t", '<CMD>lua require("FTerm").toggle()<CR>')
keymap.set("t", "<Esc>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- nvim-tree toggle
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- hop (easymotion)
keymap.set("n", "<leader>s", ":HopChar2<CR>")
