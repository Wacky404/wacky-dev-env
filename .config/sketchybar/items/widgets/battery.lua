local constants = require("constants")
local settings = require("config.settings")

local isCharging = false

local battery = sbar.add("item", constants.items.battery, {
	position = "right",
	update_freq = 60,
})

local batteryPopup = sbar.add("item", {
	position = "popup." .. battery.name,
	width = "dynamic",
	label = {
		padding_right = settings.dimensions.paddings.label,
		padding_left = settings.dimensions.paddings.label,
	},
	icon = {
		padding_left = 0,
		padding_right = 0,
	},
})

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

local function battery_update()
	local color = settings.colors.green
	local icon = "!"
	local label = "?"
	local lead = ""

	local batt_info = os.capture("pmset -g batt", true)
	if batt_info:find("AC Power") then
		icon = settings.icons.text.nerdfont.battery.charging
		local found, _, charge = batt_info:find("(%d+)%%")
		if found then
			label = charge .. "%"
		end
	else
		local found, _, charge = batt_info:find("(%d+)%%")
		if found then
			charge = tonumber(charge)
			label = charge .. "%"
		end

		if found and charge < 10 then
			lead = "0"
		end

		if found and charge > 80 then
			icon = settings.icons.text.nerdfont.battery._100
		elseif found and charge > 60 then
			icon = settings.icons.text.nerdfont.battery._75
		elseif found and charge > 40 then
			icon = settings.icons.text.nerdfont.battery._50
		elseif found and charge > 30 then
			icon = settings.icons.text.nerdfont.battery._50
			color = settings.colors.yellow
		elseif found and charge > 20 then
			icon = settings.icons.text.nerdfont.battery._25
			color = settings.colors.orange
		else
			icon = settings.icons.text.nerdfont.battery._0
			color = settings.colors.red
		end
	end

	battery:set({
		icon = {
			string = icon,
			color = color,
		},
		label = {
			string = lead .. label,
			padding_left = 0,
		},
	})
end

battery:subscribe({ "routine", "power_source_change", "system_woke" }, battery_update)

battery:subscribe("mouse.clicked", function(env)
	local drawing = battery:query().popup.drawing

	battery:set({ popup = { drawing = "toggle" } })

	if drawing == "off" then
		local batteryInfo = os.capture("pmset -g batt", true)
		local found, _, remaining = batteryInfo:find("(%d+:%d+) remaining")
		local label = found and ("Time remaining: " .. remaining .. "h") or (isCharging and "Charging" or "No estimate")
		batteryPopup:set({ label = label })
	end
end)
