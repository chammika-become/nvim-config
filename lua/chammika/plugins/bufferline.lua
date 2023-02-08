local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

-- You need to be using termguicolors for this plugin to work,
-- as it reads the hex gui color values of various highlight groups.
vim.opt.termguicolors = true

local function diag_indicator(_, _, diagnostics_dict, context)
	if context.buffer:current() then
		return ""
	end
	local s = " "
	for e, n in pairs(diagnostics_dict) do
		local sym = e == "error" and " " or (e == "warning" and " " or " ")
		s = s .. n .. sym
	end
	return s
end

bufferline.setup({
	options = {
		mode = "buffers", -- set to "tabs" to only show tabpages instead
		close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		diagnostics = "nvim_lsp",
		diagnostics_indicator = diag_indicator,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "left",
				seperator = true,
			},
		},
		seperator_style = "padded_slant",
	},
})
