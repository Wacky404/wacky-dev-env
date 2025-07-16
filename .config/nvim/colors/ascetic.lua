-- Ascetic colorscheme for Neovim
-- Monochrome low-contrast colorscheme
-- Author: Wacky404
-- License: MIT License (MIT)
-- Converted to Lua from VimScript
-- Original vimscript author Aos Dabbagh <hello@aos.sh>

local M = {}

-- Clear existing highlights
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.g.colors_name = "ascetic"

local is_dark = vim.o.background == "dark"

-- Configuration options
local ascetic_transparent_bg = 1
local ascetic_accent_colors = 1
local ascetic_highlight_strings = vim.g.ascetic_highlight_strings or 0

-- Color palette
local colors = {
	blackest = { gui = "#D1D1D1", cterm = "0" },
	black = { gui = "#212121", cterm = "0" },
	darkest_gray = { gui = "#323232", cterm = "236" },
	darker_gray = { gui = "#414141", cterm = "8" },
	dark_gray = { gui = "#767676", cterm = "242" },
	medium_gray = { gui = "#999999", cterm = "243" },
	light_gray = { gui = "#B2B2B2", cterm = "249" },
	white = { gui = "#C0C0C0", cterm = "81" },
	lighter_white = { gui = "#F1F1F1", cterm = "15" },
	actual_white = { gui = "#FFFFFF", cterm = "231" },
	green = { gui = "#9ef4a9", cterm = "68" },
}

local none = { gui = "NONE", cterm = "NONE" }

-- Theme variables based on background
local theme = {}

if is_dark then
	theme = {
		blackest = colors.blackest,
		black = colors.black,
		darkest_gray = colors.darkest_gray,
		darker_gray = colors.darker_gray,
		dark_gray = colors.dark_gray,
		medium_gray = colors.medium_gray,
		light_gray = colors.light_gray,
		white = colors.white,
		lighter_white = colors.lighter_white,
		actual_white = colors.actual_white,
	}
else
	theme = {
		blackest = colors.actual_white,
		black = colors.white,
		darkest_gray = colors.light_gray,
		darker_gray = colors.medium_gray,
		dark_gray = colors.dark_gray,
		medium_gray = colors.darker_gray,
		light_gray = colors.darkest_gray,
		white = colors.black,
		lighter_white = colors.blackest,
		actual_white = colors.blackest,
		green = colors.green,
	}
end

local bg = theme.black
local fg = theme.white

-- Accent colors (subtle and harmonious with monochrome palette)
local accent = {}
if ascetic_accent_colors == 1 then
	accent = {
		blue = { gui = "#9ef4a9", cterm = "68" }, -- terminal green
		red = { gui = "#A0A0A0", cterm = "247" }, -- Warm light gray for errors
		green = { gui = "#9ef4a9", cterm = "233" }, -- Deep black (same as blue)
		orange = { gui = "#959595", cterm = "246" }, -- Neutral gray for warnings
	}
else
	accent = {
		blue = theme.actual_white,
		red = theme.dark_gray,
		green = theme.lighter_white,
		orange = theme.light_gray,
	}
end

-- Helper function to set highlights
local function highlight(group, style)
	local cmd = "highlight " .. group

	if style.fg then
		cmd = cmd .. " guifg=" .. style.fg.gui .. " ctermfg=" .. style.fg.cterm
	else
		cmd = cmd .. " guifg=NONE ctermfg=NONE"
	end

	if style.bg then
		cmd = cmd .. " guibg=" .. style.bg.gui .. " ctermbg=" .. style.bg.cterm
	else
		cmd = cmd .. " guibg=NONE ctermbg=NONE"
	end

	if style.sp then
		cmd = cmd .. " guisp=" .. style.sp.gui
	else
		cmd = cmd .. " guisp=NONE"
	end

	if style.gui then
		cmd = cmd .. " gui=" .. style.gui
	else
		cmd = cmd .. " gui=NONE"
	end

	if style.cterm then
		cmd = cmd .. " cterm=" .. style.cterm
	else
		cmd = cmd .. " cterm=NONE"
	end

	vim.cmd(cmd)
end

-- Helper function to link highlights
local function link(from, to)
	vim.cmd("hi! link " .. from .. " " .. to)
end

-- Set highlights
if ascetic_transparent_bg == 1 then
	highlight("Normal", { fg = fg })
else
	highlight("Normal", { fg = fg, bg = bg })
end

highlight("Comment", { fg = theme.dark_gray })
highlight("Cursor", { fg = bg, bg = fg })

-- Link basic syntax groups
link("Constant", "Normal")
link("Character", "Constant")
link("Boolean", "Constant")
link("Number", "Constant")
link("Float", "Constant")
link("Identifier", "Constant")
link("Function", "Constant")
link("Statement", "Constant")
link("Conditional", "Constant")
link("Operator", "Constant")
link("Exception", "Constant")
link("PreProc", "Constant")
link("Type", "Constant")
link("Special", "Constant")

-- String highlighting
if ascetic_highlight_strings == 1 then
	highlight("String", { fg = colors.medium_gray })
else
	link("String", "Constant")
end

-- UI elements
highlight("ColorColumn", { bg = theme.darkest_gray })
link("CursorColumn", "ColorColumn")
link("CursorLine", "ColorColumn")
link("CursorLineNr", "ColorColumn")

link("Directory", "Normal")

highlight("WarningMsg", { fg = fg })
highlight("ErrorMsg", { fg = fg, gui = "reverse", cterm = "reverse" })
highlight("VertSplit", { fg = theme.black, bg = theme.black })

highlight("Folded", { fg = theme.medium_gray })
link("FoldColumn", "Folded")

highlight("SignColumn", { fg = theme.medium_gray, bg = theme.black })

highlight("LineNr", { fg = theme.dark_gray })
highlight("MatchParen", { fg = accent.green, gui = "underline", cterm = "underline" })
highlight("NonText", { fg = theme.darker_gray })

-- Popup menu
highlight("Pmenu", { fg = fg, bg = bg })
highlight("PmenuSel", { fg = fg, bg = theme.darker_gray })
highlight("PmenuSbar", { fg = fg, bg = bg })
highlight("PmenuThumb", { fg = fg, bg = bg })

-- Search (using white highlight)
highlight("Search", { fg = theme.actual_white, gui = "underline,bold", cterm = "underline,bold" })
highlight("IncSearch", { fg = theme.actual_white, gui = "reverse", cterm = "reverse" })

highlight("Question", { fg = fg })
highlight("SpecialKey", { fg = theme.darker_gray })

-- Spell checking
link("SpellBad", "Normal")
link("SpellLocal", "SpellBad")
link("SpellCap", "SpellBad")
link("SpellRare", "SpellBad")

-- Status line (transparent with blur effect)
if is_dark then
	highlight("StatusLine", { fg = theme.dark_gray, bg = none, blend = 50 })
	highlight("StatusLineNC", { fg = theme.darker_gray, bg = none, blend = 60 })
else
	-- Light mode - use darker colors for better contrast
	highlight("StatusLine", { fg = theme.medium_gray, bg = none, blend = 20 })
	highlight("StatusLineNC", { fg = theme.dark_gray, bg = none, blend = 30 })
end

-- Winbar Fix
highlight("WinBar", { fg = fg, bg = none })
highlight("WinBarNC", { fg = theme.dark_gray, bg = none })

-- Additional lualine highlights for transparency
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "ascetic",
	callback = function()
		-- Override any lualine highlights that might have backgrounds
		local lualine_groups = {
			"lualine_a_normal",
			"lualine_b_normal",
			"lualine_c_normal",
			"lualine_a_insert",
			"lualine_b_insert",
			"lualine_c_insert",
			"lualine_a_visual",
			"lualine_b_visual",
			"lualine_c_visual",
			"lualine_a_command",
			"lualine_b_command",
			"lualine_c_command",
			"lualine_a_replace",
			"lualine_b_replace",
			"lualine_c_replace",
			"lualine_x_normal",
			"lualine_y_normal",
			"lualine_z_normal",
			"lualine_x_insert",
			"lualine_y_insert",
			"lualine_z_insert",
			"lualine_x_visual",
			"lualine_y_visual",
			"lualine_z_visual",
			"lualine_x_command",
			"lualine_y_command",
			"lualine_z_command",
			"lualine_x_replace",
			"lualine_y_replace",
			"lualine_z_replace",
			"lualine_a_inactive",
			"lualine_b_inactive",
			"lualine_c_inactive",
		}

		for _, group in ipairs(lualine_groups) do
			vim.api.nvim_set_hl(0, group, { bg = "NONE", blend = 20 })
		end
	end,
})

-- Tab line
highlight("TabLine", { fg = theme.white, bg = none })
highlight("TabLineFill", { bg = none })
highlight("TabLineSel", { fg = fg, bg = theme.darker_gray })

highlight("Title", { fg = fg, gui = "bold", cterm = "bold" })
highlight("Visual", { bg = theme.darker_gray })
link("VisualNOS", "Visual")

highlight("WildMenu", { fg = fg, bg = bg, gui = "bold", cterm = "bold" })

highlight("Underlined", { gui = "underline", cterm = "underline" })

highlight("Error", { fg = accent.red })
highlight("Todo", { fg = theme.dark_gray, gui = "bold,italic", cterm = "bold,italic" })

-- Floating windows
highlight("NormalFloat", { fg = fg, bg = bg })
highlight("FloatBorder", { fg = theme.dark_gray })

-- Vim diff
highlight("DiffAdd", { fg = accent.green })
highlight("DiffChange", { fg = accent.orange })
highlight("DiffDelete", { fg = accent.red })
highlight("DiffText", { fg = accent.blue })

-- Fugitive
link("FugitiveblameHash", "Normal")
link("FugitiveblameUncommitted", "FugitiveblameHash")
link("FugitiveblameTime", "FugitiveblameHash")
link("FugitiveblameNotCommittedYet", "FugitiveblameHash")

-- Telescope
highlight("TelescopeSelection", { bg = theme.darkest_gray, gui = "bold" })
link("TelescopeMatching", "Search")

-- Terminal colors
if vim.fn.has("termguicolors") == 1 and vim.o.termguicolors then
	vim.g.terminal_ansi_colors = {
		bg.gui,
		fg.gui,
		fg.gui,
		fg.gui,
		fg.gui,
		fg.gui,
		fg.gui,
		fg.gui,
		theme.blackest.gui,
		fg.gui,
		fg.gui,
		fg.gui,
		fg.gui,
		fg.gui,
		fg.gui,
		theme.actual_white.gui,
	}
end

if vim.fn.has("nvim") == 1 then
	vim.g.terminal_color_foreground = fg.gui
	vim.g.terminal_color_background = bg.gui
	vim.g.terminal_color_0 = bg.gui
	vim.g.terminal_color_1 = fg.gui
	vim.g.terminal_color_2 = fg.gui
	vim.g.terminal_color_3 = fg.gui
	vim.g.terminal_color_4 = fg.gui
	vim.g.terminal_color_5 = fg.gui
	vim.g.terminal_color_6 = fg.gui
	vim.g.terminal_color_7 = fg.gui
	vim.g.terminal_color_8 = theme.blackest.gui
	vim.g.terminal_color_9 = fg.gui
	vim.g.terminal_color_10 = fg.gui
	vim.g.terminal_color_11 = fg.gui
	vim.g.terminal_color_12 = fg.gui
	vim.g.terminal_color_13 = fg.gui
	vim.g.terminal_color_14 = fg.gui
	vim.g.terminal_color_15 = theme.actual_white.gui
end

return M
