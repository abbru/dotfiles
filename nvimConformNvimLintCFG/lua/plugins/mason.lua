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
				"pint",
				"sql-formatter",
				"eslint_d",
				"flake8",
				"stylelint",
				--"luacheck",
				"phpstan",
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
