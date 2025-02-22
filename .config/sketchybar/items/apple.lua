local settings = require("config.settings")

local apple = sbar.add("item", "apple", {
	icon = { string = settings.icons.text.apple },
	label = { drawing = true },
	click_script = "$CONFIG_DIR/items/menus/bin/menus -s 0",
})
