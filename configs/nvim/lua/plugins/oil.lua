return {
	"stevearc/oil.nvim",
	opts = {},
	-- Optional dependencies
	-- dependencies = { "echasnovski/mini.icons" },
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
			},
		})
		vim.keymap.set("n", "<C-b>", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
	end,
}
