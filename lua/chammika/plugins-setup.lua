-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	-- Package manager
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

	use("rebelot/kanagawa.nvim") -- colorscheme

	-- essential plugins
	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation
	use("max397574/better-escape.nvim") -- faster insert mode escape
	use("szw/vim-maximizer") -- maximizes and restores current window
	use("lukas-reineke/indent-blankline.nvim") -- ident lines
	use("numToStr/FTerm.nvim") -- Terminal in Lua
	use("folke/trouble.nvim") -- Summarizes issues
	use({
		"phaazon/hop.nvim", -- easymotion port to neovim (lua)
		branch = "v2",
	})
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
	use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	use("numToStr/Comment.nvim") -- commenting with gc

	use("nvim-tree/nvim-tree.lua") -- file explorer

	-- vs-code like icons
	use("nvim-tree/nvim-web-devicons")

	-- statusline
	use({ "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons", opt = true } })
	-- bufferline
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { { "nvim-lua/plenary.nvim" } } })
	-- fzf extension for telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- configuring LSP servers
	use({
		"neovim/nvim-lspconfig",
		requires = {
			-- manage LSP servers using Mason
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim", -- bridge gap between Mason and lspconfig

			"j-hui/fidget.nvim", -- progress of lsp server
			"onsails/lspkind.nvim", -- vs-code like icons for autocompletion
		},
	})

	use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis

	-- Autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			-- various completion providers
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
	})

	-- Formatting & Linting/Diagonastics
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- rust tools
	use("simrat39/rust-tools.nvim")

	-- debugging
	use("mfussenegger/nvim-dap")

	-- Treesitter : Highlight, edit, navigate code
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- Additonal text objects via Treesitter
	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })
	use("nvim-treesitter/playground") -- for plugin dev using Treesitter

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- codeium assistant
	use({
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
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
