local settings = require("config.settings")

sbar.default({
	updates = "when_shown",
	icon = {
		font = {
			family = settings.fonts.text,
			style = settings.fonts.styles.regular,
			size = settings.dimensions.text.icon,
		},
		-- changed the apple logo & cpu
		color = settings.colors.white,
		padding_left = settings.dimensions.paddings.icon,
		padding_right = settings.dimensions.paddings.icon,
	},
	label = {
		font = {
			family = settings.fonts.text,
			style = settings.fonts.styles.regular,
			size = settings.dimensions.text.label,
		},
		-- text color for widgets
		color = settings.colors.white,
		padding_left = settings.dimensions.paddings.label,
		padding_right = settings.dimensions.paddings.label,
	},
	background = {
		height = settings.dimensions.graphics.background.height,
		corner_radius = settings.dimensions.graphics.background.corner_radius,
		border_width = 0,
		-- changes border color for widgets
		-- border_color = settings.colors.widget_borders,
		image = {
			corner_radius = settings.dimensions.graphics.background.corner_radius,
			-- border_color = settings.colors.grey,
			-- border_width = 1,
		},
	},
	popup = {
		y_offset = settings.dimensions.paddings.popup,
		align = "center",
		background = {
			border_width = 0,
			corner_radius = settings.dimensions.graphics.background.corner_radius,
			color = settings.colors.popup.bg,
			shadow = { drawing = true },
			padding_left = settings.dimensions.paddings.icon,
			padding_right = settings.dimensions.paddings.icon,
		},
		blur_radius = settings.dimensions.graphics.blur_radius,
	},
	slider = {
		highlight_color = settings.colors.orange,
		background = {
			height = settings.dimens.graphics.slider.height,
			corner_radius = settings.dimens.graphics.background.corner_radius,
			color = settings.colors.slider.bg,
			border_color = settings.colors.slider.border,
			border_width = 1,
		},
		knob = {
			font = {
				family = settings.fonts.text,
				style = settings.fonts.styles.regular,
				size = 32,
			},
			string = settings.icons.text.slider.knob,
			drawing = false,
		},
	},
	scroll_texts = true,
})
