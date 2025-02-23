local settings = require("config.settings")

sbar.bar({
	topmost = "window",
	height = settings.dimensions.graphics.bar.height,
	color = settings.colors.transparent,
	padding_right = settings.dimensions.paddings.right,
	padding = settings.dimensions.paddings.bar,
	padding_left = settings.dimensions.paddings.left,
	margin = settings.dimensions.paddings.bar,
	corner_radius = settings.dimensions.graphics.background.corner_radius,
	y_offset = settings.dimensions.graphics.bar.offset,
	blur_radius = settings.dimensions.graphics.blur_radius,
	border_width = 0,
})
