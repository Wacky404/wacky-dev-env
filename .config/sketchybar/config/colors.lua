Black = 0xff181819
White = 0xffe2e2e3
Red = 0xfffc5d7c
Blood = 0xFF8A0303
Green = 0xff9ed072
Blue = 0xff76cce0
Cog_blue = 0xff6a97b8
Yellow = 0xffe7c664
Orange = 0xfff39660
Orange_brown = 0xffC46210
Magenta = 0xffb39df3
Grey = 0xff7f8490
Pink = 0xffffc0cb
Purple = 0xff8a00c2
Transparent = 0x00000000

local colors <const> = {
	black = Black,
	white = White,
	red = Red,
	blood = Blood,
	green = Green,
	blue = Blue,
	cog_blue = Cog_blue,
	yellow = Yellow,
	orange = Orange,
	orange_brown = Orange_brown,
	magenta = Magenta,
	grey = Grey,
	pink = Pink,
	purple = Purple,
	transparent = Transparent,
	other_purple = 0xff302c45,
	cyan = 0xff7bf2de,
	dirty_white = 0xc8cad3f5,
	dark_grey = 0xff2b2736,

	bar = {
		bg = 0xf02c2e34,
		border = 0xff2c2e34,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	slider = {
		bg = 0xf1151320,
		border = 0xff2c2e34,
	},
	bg1 = 0xff363944,
	bg2 = 0xff414550,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,

	-- widgets borders; cpu, wifi, vol, batt
	widget_borders = Grey,
	-- battery widget
	batt_background = Black,
	batt_color_default = Green,
	batt_color_25 = Orange_brown,
	batt_color_0 = Grey,
	-- cpu widget
	cpu_background = Black,
	-- volume widget
	volume_background = Black,
	-- wifi widget
	wifi_background = Black,
	-- apple.lua
	apple_icon = White,
	apple_background = Black,
	apple_border = Black,
	-- calendar.lua
	calendar_background = Black,
	calendar_border = Black,
	-- spaces.lua
	spaces_highlight = White,
	spaces_icon = Grey,
	spaces_background = Black,
	spaces_border = Grey,
	spaces_selected = White,
}

return colors
