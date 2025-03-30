local dimens <const> = require("config.dimensions")

return {
	text = "SpaceMono Nerd Font",
	numbers = "SpaceMono Nerd Font",
	icons = function(size)
		local font = "Hack Nerd Font:Bold:14.0"
		return size and font .. ":" .. size or font .. ":" .. dimens.text.icon
	end,
	styles = {
		regular = "Regular",
		bold = "Bold",
	},
}
