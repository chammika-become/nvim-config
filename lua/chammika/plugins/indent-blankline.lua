local setup, indent = pcall(require, "indent-blankline")
if not setup then
	return
end

indent.setup({
	-- char = '┊',
	char = " ",
	use_treesitter = true,
	use_treesitter_scope = true,
	show_first_indent_level = true,
	space_char_blankline = " ",
})
