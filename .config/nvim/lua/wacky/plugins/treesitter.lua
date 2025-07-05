-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-ts-autotag")
if not status then
	return
end

-- configure treesitter
treesitter.setup({
	-- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable indentation
	indent = { enable = true },
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	autotag = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"arduino",
		"c",
		"cpp",
		"latex",
		"python",
		"json",
		"markdown",
		"markdown_inline",
		"bash",
		"lua",
		"vim",
		"gitignore",
		"html",
		"javascript",
		"typescript",
		"tsx",
	},
	-- auto install above language parsers
	auto_install = true,
})
