-- specifies linter for each filetype
require("lint").linters_by_ft = {
	python = { "mypy" },
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	jac = { "jaclint" },
}

require("lint").linters.jaclint = {
	cmd = "sh",
	args = { "-c", 'jac lint --no-fix "$1" || true', "--" },
	stdin = false,
	parser = function(output, bufnr)
		if not output or output == "" then
			return {}
		end
		local diagnostics = {}
		local cleaned = output:gsub("✖ Error: ", ""):gsub("\ncol ", " col ")
		for line in vim.gsplit(cleaned, "\n", { plain = true }) do
			local file, line_num, col, message = line:match("(.+), line (%d+), col (%d+): (.+)")
			if file and line_num and col and message then
				table.insert(diagnostics, {
					bufnr = bufnr,
					lnum = tonumber(line_num) - 1,
					col = tonumber(col) - 1,
					end_lnum = tonumber(line_num) - 1,
					end_col = tonumber(col),
					severity = vim.diagnostic.severity.ERROR,
					message = message,
					source = "jaclint",
				})
			end
		end
		return diagnostics
	end,
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		-- try_lint without arguments runs the linters defined in `linters_by_ft`
		-- for the current filetype
		require("lint").try_lint()

		-- You can call `try_lint` with a linter name or a list of names to always
		-- run specific linters, independent of the `linters_by_ft` configuration
		-- require("lint").try_lint("cspell")
	end,
})
