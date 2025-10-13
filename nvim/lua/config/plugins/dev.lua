return {
	{
		dir = "~/Github/nvim_plugins/embrace.nvim",
		config = function()
			require("embrace").setup()
		end,
	},
	{
		dir = "~/Github/nvim_plugins/surf.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("surf").setup({
				default_engine = "DuckDuckGo",
				engines = {
					Elixir = { bang = "!ex", url = "https://hexdocs.pm/elixir/search.html?q=%s" },
					GoogleScholar = { bang = "!gs", url = "https://scholar.google.com/scholar?q=%s&hl=en" },
					Golang = { bang = "!go", url = "https://pkg.go.dev/search?limit=25&m=package&q=%s" },
				}
			})
		end,
	},
}
