local constants = require("constants")
local settings = require("config.settings")

sbar.add("event", constants.events.SWAP_MENU_AND_SPACES)

local function switchToggle(menuToggle)
	local isShowingMenu = menuToggle:query().icon.value == settings.icons.text.nerdfont.switch.on

	menuToggle:set({
		icon = isShowingMenu and settings.icons.text.nerdfont.switch.off or settings.icons.text.nerdfont.switch.on,
		label = isShowingMenu and "Menus" or "Spaces",
	})

	sbar.trigger(constants.events.SWAP_MENU_AND_SPACES, { isShowingMenu = isShowingMenu })
end

local function addToggle()
	local menuToggle = sbar.add("item", constants.items.MENU_TOGGLE, {
		icon = {
			string = settings.icons.text.nerdfont.switch.on,
		},
		label = {
			width = 0,
			color = settings.colors.white,
			string = "Spaces",
		},
		background = {
			color = settings.colors.with_alpha(settings.colors.dark_grey, 0.0),
		},
	})

	sbar.add("item", constants.items.MENU_TOGGLE .. ".padding", {
		width = settings.dimensions.paddings.label,
	})

	menuToggle:subscribe("mouse.entered", function(env)
		sbar.animate("tanh", 30, function()
			menuToggle:set({
				background = {
					color = { alpha = 1.0 },
					border_color = { alpha = 0.5 },
				},
				icon = { color = settings.colors.white },
				label = { width = "dynamic" },
			})
		end)
	end)

	menuToggle:subscribe("mouse.exited", function(env)
		sbar.animate("tanh", 30, function()
			menuToggle:set({
				background = {
					color = { alpha = 0.0 },
					border_color = { alpha = 0.0 },
				},
				icon = { color = settings.colors.white },
				label = { width = 0 },
			})
		end)
	end)

	menuToggle:subscribe("mouse.clicked", function(env)
		switchToggle(menuToggle)
	end)

	menuToggle:subscribe(constants.events.AEROSPACE_SWITCH, function(env)
		switchToggle(menuToggle)
	end)
end

addToggle()
