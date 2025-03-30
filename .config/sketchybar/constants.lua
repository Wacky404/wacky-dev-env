local events <const> = {
	AEROSPACE_WORKSPACE_CHANGED = "aerospace_workspace_changed",
	AEROSPACE_WINDOWS_CHANGED = "aerospace_windows_changed",
	SKETCHY_WINDOWS_CHANGED = "space_windows_changed",
	AEROSPACE_SWITCH = "aerospace_switch",
	SWAP_MENU_AND_SPACES = "swap_menu_and_spaces",
	FRONT_APP_SWITCHED = "front_app_switched",
	UPDATE_WINDOWS = "update_windows",
	UPDATE_MOVED_WINDOWS = "update_moved_windows",
	USER_TRIGGER_FRONTAPP = "manual_trigger_front_app",
	SEND_MESSAGE = "send_message",
	HIDE_MESSAGE = "hide_message",
}

local items <const> = {
	SPACES = "workspaces",
	MENU = "menu",
	MENU_TOGGLE = "menu_toggle",
	FRONT_APPS = "front_apps",
	MESSAGE = "message",
	VOLUME = "widgets.volume",
	WIFI = "widgets.wifi",
	BATTERY = "widgets.battery",
	CALENDAR = "widgets.calendar",
	CPU = "widgets.cpu",
}

local aerospace <const> = {
	LIST_ALL_WORKSPACES = "aerospace list-workspaces --all",
	GET_CURRENT_WORKSPACE = "aerospace list-workspaces --focused",
	LIST_WINDOWS = 'aerospace list-windows --workspace focused --format "id=%{window-id}, name=%{app-name}"',
	GET_CURRENT_WINDOW = "aerospace list-windows --focused --format %{app-name}",
}

return {
	items = items,
	events = events,
	aerospace = aerospace,
}
