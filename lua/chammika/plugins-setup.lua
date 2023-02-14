-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim require leader mapping to work correctl
-- make sure leader is mapped by this point

-- add list of plugins to install
require("lazy").setup({
	-- Package manager
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use

	"rebelot/kanagawa.nvim", -- colorscheme

	-- essential plugins
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	"max397574/better-escape.nvim", -- faster insert mode escape
	"szw/vim-maximizer", -- maximizes and restores current window
	"lukas-reineke/indent-blankline.nvim", -- show vertical indent guides
	"numToStr/FTerm.nvim", -- Terminal in Lua
	"folke/trouble.nvim", -- Summarizes issues
	{
		"phaazon/hop.nvim", -- easymotion port to neovim (lua)
		branch = "v2",
	},
	"nvim-tree/nvim-tree.lua", -- file explorer

	{
		"kylechui/nvim-surround",
		branch = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	-- chammika mannakkara
	"numToStr/Comment.nvim", -- commenting with gc
	"inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)

	-- vs-code like icons
	"nvim-tree/nvim-web-devicons",

	-- statusline
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } },
	-- bufferline
	{ "akinsho/bufferline.nvim", branch = "v3.*", dependencies = "nvim-tree/nvim-web-devicons" },

	-- fuzzy finding w/ telescope
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { { "nvim-lua/plenary.nvim" } } },
	-- fzf extension for telescope
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	-- snippets
	"L3MON4D3/LuaSnip", -- snippet engine
	"saadparwaiz1/cmp_luasnip", -- for autocompletion
	"rafamadriz/friendly-snippets", -- useful snippets

	-- configuring LSP servers
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- manage LSP servers using Mason
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim", -- bridge gap between Mason and lspconfig

			"j-hui/fidget.nvim", -- progress of lsp server
			"onsails/lspkind.nvim", -- vs-code like icons for autocompletion
		},
	},

	{ "glepnir/lspsaga.nvim", branch = "main" }, -- enhanced lsp uis

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- various completion providers
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
	},

	-- Formatting & Linting/Diagonastics
	"jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
	"jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls

	-- rust tools
	"simrat39/rust-tools.nvim",

	-- debugging
	"mfussenegger/nvim-dap",

	-- Treesitter : Highlight, edit, navigate code
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
	},

	"nvim-treesitter/playground", -- for plugin dev using Treesitter

	-- auto closing
	"windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...

	-- git integration
	"lewis6991/gitsigns.nvim", -- show line modifications on left hand side

	-- codeium assistant
	{
		"Exafunction/codeium.vim",
		config = function()
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<c-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<c-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
		end,
	},
})
