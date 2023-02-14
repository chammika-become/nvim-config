-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

lspkind.init({
	mode = "symbol_text",
	preset = "codicons",
})

local ts_utils = require("nvim-treesitter.ts_utils")

-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),

	-- sources for autocompletion
	sources = cmp.config.sources({
		-- lsp
		{
			name = "nvim_lsp",
			entry_filter = function(entry, _)
				local kind = entry:get_kind()
				local node = ts_utils.get_node_at_cursor():type()
				if node == "arguments" then
					if kind == 6 then -- variables
						return true
					else
						return false
					end
				end
				return true
			end,
		},
		{ name = "nvim_lsp_signature_help" }, -- function signatures
		{ name = "luasnip" }, -- snippets
		--		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}, {
		{ name = "buffer", keyword_length = 3 },
	}),
	-- configure lspkind for vs-code like icons
	formatting = {
		-- fields = { "abbr", "kind" }, -- remove "menu" to keep dropdown small (sp in Rust)
		format = function(entry, vim_item)
			vim_item.menu = "[" .. entry.source.name .. "]"
			vim_item.abbr = vim_item.abbr:match("[^(]+") -- strip parameters from function
			if vim.tbl_contains({ "path" }, entry.source.name) then
				local devicons = require("nvim-web-devicons")
				local icon, hl_group = devicons.get_icon(entry:get_completion_item().label)
				if icon then
					vim_item.kind = icon
					vim_item.kind_hl_group = hl_group
					return vim_item
				end
			end
			return lspkind.cmp_format({ with_text = true })(entry, vim_item)
		end,
	},
	-- window
	window = {
		completion = {
			cmp.config.window.bordered({ border = "double" }),
			col_offset = 0,
			side_padding = 1,
		},
		documentation = cmp.config.window.bordered(),
	},
})
