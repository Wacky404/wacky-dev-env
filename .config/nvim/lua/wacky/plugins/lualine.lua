local status, lualine = pcall(require, "lualine")
if not status then
	return
end

lualine.setup({
	options = {
		theme = "auto",
		section_separators = "",
		component_separators = "",
	},
})
