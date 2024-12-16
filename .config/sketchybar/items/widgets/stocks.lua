local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local sbar = require("sketchybar")

local popup_width = 250

local stock_icon = sbar.add("item", "widgets.stocks", {
	position = "middle",
	icon = { drawing = false },
	label = {
		string = "$??.??", -- this needs to be formatted depending on the data
		padding_left = -1,
		font = { family = settings.font.numbers },
	},
})
