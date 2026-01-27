return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.config")

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			sync_install = true, -- install synchronously
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },
			-- enable injections for embedded languages
			injections = { enable = true },
			-- ensure these language parsers are installed
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"c",
				"go",
				"templ",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})

		-- use bash parser for zsh files
		vim.treesitter.language.register("bash", "zsh")

		-- Configure templ parser
		require("nvim-treesitter.parsers").templ = {
			install_info = {
				url = "https://github.com/vrischmann/tree-sitter-templ",
				branch = "main",
				queries = "queries/templ",
			},
		}

		-- Enable treesitter for templ files
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "templ",
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
