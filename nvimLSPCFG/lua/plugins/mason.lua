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
				"astro-language-server",
				"typescript-language-server",
				"stylua",
				"prettier",
				"black",
				"rust-analyzer",
				"shfmt",
				"pint",
				"sql-formatter",
				"eslint_d",
				"flake8",
				"stylelint",
				--"luacheck",
				"intelephense",
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
