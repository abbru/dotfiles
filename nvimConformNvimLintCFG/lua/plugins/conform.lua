return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				svelte = { "prettier" },
				astro = { "prettier" },
				python = { "black" },
				rust = { "rust_analyzer" },
				sh = { "shfmt" },
				css = { "prettier" },
				--php = { "pint" },
				json = { "prettier" },
				markdown = { "prettier" },
				markdown_inline = { "prettier" },
				sql = { "sql-formatter" },
				tsx = { "prettier" },
				jsx = { "prettier" },
				vim = { "vim-beautify" },
				yaml = { "prettier" },
				regex = { "beautysh" },
			},
		})

		-- Ejecutar conform.nvim al guardar
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function()
				require("conform").format()
			end,
		})

		vim.keymap.set("n", "<leader>lf", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { desc = "Formatear código" })
	end,
}
