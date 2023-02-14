local opt = vim.opt

-- enable mouse for all modes
opt.mouse = "a"

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- global statusline
opt.laststatus = 3

-- decrease updatetime for snappier performance (can lead to glitches)
opt.updatetime = 200
opt.timeoutlen = 300

-- visible separators for panes
vim.cmd([[highlight winSeperator guifg=gray]])

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- set completeopt to have better completion
opt.completeopt = "menuone,noselect"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- keyword contains hypen : aa-bb is one keyword
opt.iskeyword:append("-")

-- highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
})
