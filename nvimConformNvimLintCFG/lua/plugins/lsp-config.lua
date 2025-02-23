return {
	--[[{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},--]]
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
	},
	{
		"williamoman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.astro.setup({ filetypes = { "astro" } })
			lspconfig.intelephense.setup({
				settings = {
					intelephense = {
						format = {
							braces = "k%r",
						},
					},
				},
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
