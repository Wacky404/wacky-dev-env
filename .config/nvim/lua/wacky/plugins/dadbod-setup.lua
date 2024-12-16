local status, _ = pcall(require, "dadbod-ui")
if not status then
	return
end

vim.g.db_ui_variable_prefix = "DB_"
