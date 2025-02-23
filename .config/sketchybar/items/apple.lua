local settings = require("config.settings")

local apple = sbar.add("item", "apple", {
	icon = { string = settings.icons.text.nerdfont.apple, font = { size = 20 } },
	label = { drawing = false },
	click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0",
})
