vim.cmd("set background=light")
vim.cmd("colorscheme zenburned")
vim.g.zenbones = {
	transparent_background = true,
	lightness = "bright",
	darkness = "stark",
}

--require("bluloco").setup({
--	style = "light", -- "auto" | "dark" | "light"
--	transparent = true,
--	italics = false,
--	terminal = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
--	guicursor = true,
--})

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
