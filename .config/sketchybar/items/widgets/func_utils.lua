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

-- testing battery info here... works
Batt_info = os.capture("pmset -g batt", false)
if Batt_info:find("AC Power") then
	print("Found AC Power in the string.")
else
	local found, _, charge = Batt_info:find("(%d+)%%")
	print("found: " .. found)
	print("_: " .. _)
	print("charge: " .. charge)
end
