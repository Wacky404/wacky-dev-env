-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- for sameness
local lspconfig = vim.lsp
local keymap = vim.keymap

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	keymap.set("n", "<leader>f", "<cmd>Lspsaga finder<CR>", opts)
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#FF0000" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#FFA500" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#00FFFF" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#00FF00" })

lspconfig.config("html", {
	filetypes = { "html", "typescriptreact", "javascriptreact" },
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.config("gopls", {
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.config("lua_ls", {
	cmd = { "lua-language-server", "--force-accept-workspace" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			--workspace = {
			--	library = {
			--		-- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
			--		-- [vim.fn.stdpath("config") .. "/lua"] = true,
			--	},
			--},
		},
	},
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Configure other servers with default settings
local servers = {
	"clangd",
	"arduino_language_server",
	"ltex",
	"jedi_language_server",
	"ts_ls",
	"tailwindcss",
	"metals",
	"htmx",
}

for _, server in pairs(servers) do
	lspconfig.config(server, {
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- Enable all configured servers
local all_servers = {
	"clangd",
	"arduino_language_server",
	"ltex",
	"jedi_language_server",
	"ts_ls",
	"tailwindcss",
	"metals",
	"htmx",
	"html",
	"gopls",
	"lua_ls",
}

for _, server in pairs(all_servers) do
	lspconfig.enable(server)
end
