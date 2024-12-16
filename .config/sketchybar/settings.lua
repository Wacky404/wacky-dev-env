local colors = require("colors")
return {
	-- widgets borders; cpu, wifi, vol, batt
	widget_borders = colors.grey,
	-- battery widget
	batt_background = colors.black,
	batt_color_default = colors.green,
	batt_color_25 = colors.purple,
	batt_color_0 = colors.pink,
	-- cpu widget
	cpu_background = colors.black,
	-- volume widget
	volume_background = colors.black,
	-- wifi widget
	wifi_background = colors.black,
	-- apple.lua
	apple_icon = colors.white,
	apple_background = colors.black,
	apple_border = colors.black,
	-- calendar.lua
	calendar_background = colors.black,
	calendar_border = colors.black,
	-- spaces.lua
	spaces_highlight = colors.pink,
	spaces_icon = colors.grey,
	spaces_background = colors.black,
	spaces_border = colors.grey,
	spaces_selected = colors.white,

	paddings = 3,
	group_paddings = 5,

	icons = "sf-symbols", -- alternatively available: NerdFont

	-- This is a font configuration for SF Pro and SF Mono (installed manually)
	font = require("helpers.default_font"),

	-- Alternatively, this is a font config for JetBrainsMono Nerd Font
	-- font = {
	--   text = "JetBrainsMono Nerd Font", -- Used for text
	--   numbers = "JetBrainsMono Nerd Font", -- Used for numbers
	--   style_map = {
	--     ["Regular"] = "Regular",
	--     ["Semibold"] = "Medium",
	--     ["Bold"] = "SemiBold",
	--     ["Heavy"] = "Bold",
	--     ["Black"] = "ExtraBold",
	--   },
	-- },
}
