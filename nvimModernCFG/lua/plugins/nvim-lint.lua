return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			--lua = { "luacheck" },
			javascript = { "eslint" },
			typescript = { "eslint" },
			svelte = { "eslint" },
			astro = { "eslint" },
			python = { "flake8" },
			rust = { "clippy" },
			sh = { "shellcheck" },
			php = { "phpstan" },
			json = { "jsonlint" },
			markdown = { "markdownlint" },
			markdown_inline = { "markdownlint" },
			sql = { "sqlfluff" },
			tsx = { "eslint" },
			jsx = { "eslint" },
			vim = { "vint" },
			yaml = { "yamllint" },
			regex = { "regexlint" }, -- Opcional, no todos los linters soportan regex
		}

		-- Ejecutar linters automáticamente al guardar
		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})

		-- Keymap manual para ejecutar linters con <leader>ll
		vim.keymap.set("n", "<leader>ll", function()
			require("lint").try_lint()
		end, { desc = "Ejecutar linters manualmente" })
	end,
}
