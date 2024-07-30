local icons = require("icons")
local settings = require("settings")
local sbar = require("sketchybar")

function os.capture(cmd, raw)
	local file = assert(io.popen(cmd, "r"))
	local output = assert(file:read("*a"))
	file:close()

	if raw then
		return output
	end

	output = string.gsub(output, "^%s+", "")
	output = string.gsub(output, "%s+$", "")
	output = string.gsub(output, "[\n\r]+", "")

	return output
end

local battery = sbar.add("item", "widgets.battery", {
	position = "right",
	icon = {
		font = {
			style = settings.font.style_map["Regular"],
			size = 19.0,
		},
	},
	label = { font = { family = settings.font.numbers } },
	update_freq = 180,
	popup = { align = "center" },
})

local remaining_time = sbar.add("item", {
	position = "popup." .. battery.name,
	icon = {
		string = "Time remaining:",
		width = 100,
		align = "left",
	},
	label = {
		string = "??:??h",
		width = 100,
		align = "right",
	},
})

-- TODO: This is where the battery widget issue is occuring...
local function battery_update()
	Color = settings.batt_color_default

	local batt_info = os.capture("pmset -g batt", false)
	local icon = "!"
	local label = "?"

	if batt_info:find("AC Power") then
		icon = icons.battery.charging
	else
		local found, _, charge = batt_info:find("(%d+)%%")
		if found then
			charge = tonumber(charge)
			label = charge .. "%"
		end

		if found and charge > 80 then
			icon = icons.battery._100
		elseif found and charge > 60 then
			icon = icons.battery._75
		elseif found and charge > 40 then
			icon = icons.battery._50
		elseif found and charge > 20 then
			icon = icons.battery._25
			Color = settings.batt_color_25
		else
			icon = icons.battery._0
			Color = settings.batt_color_0
		end
	end
    -- TODO: Add in charging percentage
	local lead = ""
	if label == "?" then
		label = "W"
	end

	battery:set({
		icon = {
			string = icon,
			color = Color,
		},
		label = { string = lead .. label },
	})
end

battery:subscribe({ "routine", "power_source_change", "system_woke" }, battery_update)

battery:subscribe("mouse.clicked", function(env)
	local drawing = battery:query().popup.drawing
	battery:set({ popup = { drawing = "toggle" } })

	if drawing == "off" then
		sbar.exec("pmset -g batt", function(batt_info)
			local found, _, remaining = batt_info:find(" (%d+:%d+) remaining")
			local label = found and remaining .. "h" or "No estimate"
			remaining_time:set({ label = label })
		end)
	end
end)

sbar.add("bracket", "widgets.battery.bracket", { battery.name }, {
	-- changes color of widget background
	background = { color = settings.batt_background },
})

sbar.add("item", "widgets.battery.padding", {
	position = "right",
	width = settings.group_paddings,
})
