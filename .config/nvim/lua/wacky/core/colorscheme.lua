require("kanso").setup({
	compile = false, -- enable compiling the colorscheme
	undercurl = true, -- enable undercurls
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = {},
	typeStyle = {},
	disableItalics = false,
	transparent = true, -- do not set background color
	dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	terminalColors = false, -- define vim.g.terminal_color_{0,17}
	colors = { -- add/modify theme and palette colors
		palette = {},
		theme = { zen = {}, pearl = {}, ink = {}, all = {} },
	},
	overrides = function(colors) -- add/modify highlights
		return {}
	end,
	theme = "zen", -- Load "zen" theme
	background = { -- map the value of 'background' option to a theme
		dark = "zen", -- try "ink" !
		light = "pearl",
	},
})

-- setup must be called before loading
vim.cmd("colorscheme kanso")

-- This is for the Zenbone Theme
-- vim.cmd("set background=light")
-- vim.cmd("colorscheme zenburned")
-- vim.g.zenbones = {
-- 	transparent_background = true,
-- 	lightness = "bright",
-- 	darkness = "stark",
-- }

-- This is for the Bluloco Theme
--require("bluloco").setup({
--	style = "light", -- "auto" | "dark" | "light"
--	transparent = true,
--	italics = false,
--	terminal = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
--	guicursor = true,
--})

-- This is for the tokyonight Theme; one of my favorites
-- require("tokyonight").setup({
-- 	-- your configuration comes here
-- 	-- or leave it empty to use the default settings
-- 	style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
-- 	light_style = "day", -- The theme is used when the background is set to light
-- 	transparent = true, -- Enable this to disable setting the background color
-- 	terminal_colors = false, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
-- 	styles = {
-- 		-- Style to be applied to different syntax groups
-- 		-- Value is any valid attr-list value for `:help nvim_set_hl`
-- 		comments = { italic = true },
-- 		keywords = { italic = true },
-- 		functions = {},
-- 		variables = {},
-- 		-- Background styles. Can be "dark", "transparent" or "normal"
-- 		sidebars = "transparent", -- style for sidebars, see below
-- 		floats = "transparent", -- style for floating windows
-- 	},
-- 	sidebars = { "terminal", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
-- 	day_brightness = 0.5, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
-- 	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
-- 	dim_inactive = false, -- dims inactive windows
-- 	lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
-- })
