return {
	-- in hex
	black = 0xff181819,
	white = 0xffe2e2e3,
	red = 0xfffc5d7c,
	blood = 0xFF8A0303,
	green = 0xff9ed072,
	blue = 0xff76cce0,
	cog_blue = 0xff6a97b8,
	yellow = 0xffe7c664,
	orange = 0xfff39660,
	orange_brown = 0xffC46210,
	magenta = 0xffb39df3,
	grey = 0xff7f8490,
	pink = 0xffffc0cb,
	purple = 0xff8a00c2,
	transparent = 0x00000000,

	bar = {
		bg = 0xf02c2e34,
		border = 0xff2c2e34,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg1 = 0xff363944,
	bg2 = 0xff414550,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
