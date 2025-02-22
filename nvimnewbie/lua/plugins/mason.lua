return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim", -- Opcional, si usas LSPs
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- Instala automáticamente herramientas
	},
	config = function()
		require("mason").setup({})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"stylua",
				"prettier",
				"black",
				"rust_analyzer",
				"shfmt",
				"php-cs-fixer",
				"sql-formatter",
				"eslint_d",
				"flake8",
				--"luacheck",
				"phpcs",
				"jsonlint",
				"markdownlint",
				"sqlfluff",
				"beautysh",
				"vint",
				"yamllint",
			},
		})
	end,
}
