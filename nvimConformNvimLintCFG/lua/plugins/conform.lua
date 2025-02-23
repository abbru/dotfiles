return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			svelte = { "prettier" },
			astro = { "prettier" },
			python = { "black" },
			rust = { "rustfmt" },
			sh = { "shfmt" },
			css = { "prettier" },
			--php = { "pint" },
			json = { "prettier" },
			markdown = { "prettier" },
			markdown_inline = { "prettier" },
			tsx = { "prettier" },
			jsx = { "prettier" },
			yaml = { "prettier" },
			regex = { "beautysh" },
		},
		formatters = {
			prettier = {
				args = function(self, ctx)
					if vim.endswith(ctx.filename, ".astro") then
						return {
							"--stdin-filepath",
							"$FILENAME",
							"--plugin",
							"prettier-plugin-astro",
							"--plugin",
							"prettier-plugin-tailwindcss",
						}
					end
					return { "--stdin-filepath", "$FILENAME", "--plugin", "prettier-plugin-tailwindcss" }
				end,
			},
		},
		format_on_save = {
			timeout_ms = 2500,
			async = true,
			lsp_fallback = true,
		},
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		conform.formatters.prettier = {
			prepend_args = { "--prose-wrap", "always" },
		}

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
