local setup, fterm = pcall(require, "FTerm")
if not setup then
	return
end

fterm.setup({
	border = "single",
	-- cmd = os.getenv('SHELL'),
	cmd = "zsh",
	blend = 0,
	dimensions = {
		height = 0.50,
		width = 0.75,
	},
})
