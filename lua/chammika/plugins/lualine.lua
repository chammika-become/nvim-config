local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local theme = require("lualine.themes.nord")

-- configure lualine with modified theme
lualine.setup({
	options = {
		theme = theme,
	},
})
