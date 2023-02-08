local status, hop = pcall(require, "hop")
if not status then
	return
end

-- configure hop
hop.setup({
	keys = "etovxqpdygfblzhckisuran",
})
