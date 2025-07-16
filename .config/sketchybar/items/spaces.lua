-- TODO: Highlighting is kinda fixed, multiple windows in one space label is broken, last two things, but annoying
local constants = require("constants")
local settings = require("config.settings")

local spaces = {}

local swapWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local currentWorkspaceWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local function selectCurrentWorkspace(focusedWorkspaceName)
	for sid, item in pairs(spaces) do
		if item ~= nil then
			local isSelected = sid == constants.items.SPACES .. "." .. focusedWorkspaceName
			item:set({
				icon = { color = isSelected and settings.colors.black or settings.colors.white },
				label = { color = isSelected and settings.colors.bg2 or settings.colors.white },
				background = { color = isSelected and settings.colors.green or settings.colors.bg1 },
			})
		end
	end

	-- sbar.trigger(constants.events.UPDATE_WINDOWS)
end

local function findAndSelectCurrentWorkspace()
	sbar.exec(constants.aerospace.GET_CURRENT_WORKSPACE, function(focusedWorkspaceOutput)
		local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
		selectCurrentWorkspace(focusedWorkspaceName)
	end)
end

local function addWorkspaceItem(workspaceName)
	local spaceName = constants.items.SPACES .. "." .. workspaceName

	spaces[spaceName] = sbar.add("item", spaceName, {
		label = {
			width = 0,
			padding_left = 0,
			string = "Empty",
		},
		icon = {
			string = workspaceName,
			font = settings.fonts.icons(),
			color = settings.colors.white,
		},
		background = {
			color = settings.colors.bg1,
		},
		click_script = "aerospace workspace " .. workspaceName,
	})

	spaces[spaceName]:subscribe("mouse.entered", function(env)
		sbar.animate("tanh", 30, function()
			spaces[spaceName]:set({ label = { width = "dynamic" } })
		end)
	end)

	spaces[spaceName]:subscribe("mouse.exited", function(env)
		sbar.animate("tanh", 30, function()
			spaces[spaceName]:set({ label = { width = 0 } })
		end)
	end)

	sbar.add("item", spaceName .. ".padding", {
		width = settings.dimensions.paddings.label,
	})
end

local function updateWorkspaceItem(workspaceWindows, spacePos)
	local space = constants.items.SPACES .. "." .. spacePos
	-- spaces[space] = nil
	-- sbar.remove("/" .. constants.items.SPACES .. "\\." .. spacePos .. "/")
	local foundWindows = {}
	if workspaceWindows then
		foundWindows = workspaceWindows:gmatch("[^\n]+")
	end

	local windowsInSpace = {}
	local firstIcon = nil
	local firstWinID = nil
	local cnt = 0
	if foundWindows ~= nil and foundWindows ~= "" then
		for window in foundWindows do
			cnt = cnt + 1
			local parsedWindow = {}
			for key, value in string.gmatch(window, "(%w+)=([%w%s]+)") do
				parsedWindow[key] = value
			end

			local windowName = parsedWindow["name"]
			local icon = settings.icons.apps[windowName] or settings.icons.apps["default"]
			table.insert(windowsInSpace, windowName)

			if cnt == 1 then
				firstIcon = icon
				firstWinID = parsedWindow["id"]
			end
		end
	elseif foundWindows == "" then
		print("!!! no windows in " .. space .. "moving along !!!")
	else
		print("nothing works anymore... and your gonna carry that weight")
	end

	spaces[space]:set("item", space, {
		label = {
			width = 0,
			padding_left = 0,
			string = table.concat(windowsInSpace, " ") or "Empty",
		},
		icon = {
			string = firstIcon or settings.icons.apps["default"],
			font = settings.fonts.icons(),
			color = settings.colors.white,
		},
		background = {
			color = settings.colors.bg1,
		},
		click_script = "aerospace focus --window-id " .. tostring(firstWinID),
	})

	spaces[space]:subscribe("mouse.entered", function(env)
		sbar.animate("tanh", 30, function()
			spaces[space]:set({ label = { width = "dynamic" } })
		end)
	end)

	spaces[space]:subscribe("mouse.exited", function(env)
		sbar.animate("tanh", 30, function()
			spaces[space]:set({ label = { width = 0 } })
		end)
	end)

	sbar.add("item", space .. ".padding", {
		width = settings.dimensions.paddings.label,
	})
end

local function triggerWorkspaceUpdates(focusedWorkSpace)
	sbar.exec(constants.aerospace.LIST_ALL_WORKSPACES, function(workspacesOutput)
		-- sbar.remove("/" .. constants.items.FRONT_APPS .. "\\.*/")
		-- sbar.remove("/" .. constants.items.SPACES .. "\\.*/")
		workspacesOutput = workspacesOutput:gmatch("[^\r\n]+")

		for wpName in workspacesOutput do
			addWorkspaceItem(wpName)
		end

		-- so sbar.exec() doesn't trigger the function if output is nothing from cmd; lazy workaround
		for i = 1, 5, 1 do
			sbar.exec(
				"aerospace list-windows --workspace " .. i .. ' --format "id=%{window-id}, name=%{app-name}"',
				function(workspaceWindows)
					updateWorkspaceItem(workspaceWindows, i)
				end
			)
		end

		if focusedWorkSpace then
			selectCurrentWorkspace(focusedWorkSpace)
		end
	end)
end

local function createWorkspaces()
	sbar.exec(constants.aerospace.LIST_ALL_WORKSPACES, function(workspacesOutput)
		sbar.exec('aerospace list-windows --all --format "id=%{window-id}, name=%{app-name}"', function(anyWindows)
			triggerWorkspaceUpdates()
		end)
		-- if ~tableContains(sbar.query("items"), "workspaces.1") then
		-- 	print()
		-- 	for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
		-- 		print("addWorkspaceItem(workspaceName)")
		-- 		addWorkspaceItem(workspaceName)
		-- 	end
		-- end
	end)
	findAndSelectCurrentWorkspace()
end

-- that button on the left side
swapWatcher:subscribe(constants.events.SWAP_MENU_AND_SPACES, function(env)
	local isShowingSpaces = env.isShowingMenu == "off" and true or false
	sbar.set("/" .. constants.items.SPACES .. "\\..*/", { drawing = isShowingSpaces })
end)

-- highlighting
currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
	triggerWorkspaceUpdates(env.FOCUSED_WORKSPACE)
end)

-- entry point
createWorkspaces()
