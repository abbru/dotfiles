return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "AndreM222/copilot-lualine" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "grubox_dark",
			},
			sections = {
				lualine_x = { "encoding", "copilot", "fileformat", "filetype" },
			},
		})
	end,
}
