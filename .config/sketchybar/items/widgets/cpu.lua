local constants = require("constants")
local settings = require("config.settings")

-- Execute the event provider binary which provides the event "cpu_update" for
-- the cpu load data, which is fired every 2.0 seconds.
sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 2.0")

local cpu = sbar.add("graph", constants.items.CPU, 42, {
	position = "right",
	graph = { color = settings.colors.blue },
	background = {
		height = 16,
		color = { alpha = 0 },
		border_color = { alpha = 0 },
		drawing = true,
	},
	icon = { string = settings.icons.text.nerdfont.cpu },
	label = {
		string = "cpu ??%",
		font = {
			family = settings.fonts.text,
			style = settings.fonts.styles.regular,
			size = settings.dimensions.text.label,
		},
		align = "right",
		padding_left = settings.dimensions.paddings.label,
		padding_right = 0,
		y_offset = 0,
	},
	padding_right = 0,
})

-- Background around the cpu item
sbar.add("bracket", constants.items.CPU .. ".bracket", {
	cpu.name,
}, {
	popup = { align = "center" },
})

cpu:subscribe("cpu_update", function(env)
	-- Also available: env.user_load, env.sys_load
	local load = tonumber(env.total_load)
	cpu:push({ load / 100. })

	local color = settings.colors.blue
	if load > 30 then
		if load < 60 then
			color = settings.colors.yellow
		elseif load < 80 then
			color = settings.colors.orange
		else
			color = settings.colors.red
		end
	end

	cpu:set({
		graph = { color = color },
		label = "cpu " .. env.total_load .. "%",
	})
end)

cpu:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Activity Monitor'")
end)
