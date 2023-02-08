local status, fidget = pcall(require, "fidget")
if not fidget then
	return
end

fidget.setup({
	text = {
		spinner = "dots",
		done = "✔",
		commenced = "Started",
		completed = "Completed",
	},
	window = {
		relative = "editor",
		blend = 10,
	},
})
