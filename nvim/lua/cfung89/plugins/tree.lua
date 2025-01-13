return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				filters = {
					dotfiles = false,
				},
			})
			vim.keymap.set("n", "<leader>t", ":NvimTreeFindFileToggle<cr>")
		end,
	},
}
