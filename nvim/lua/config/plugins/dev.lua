return {
	{
		dir = "~/Github/nvim_plugins/embrace.nvim",
		config = function()
			require("embrace").setup()
		end,
	},
	{
		dir = "~/Github/nvim_plugins/surf.nvim",
		config = function()
			require("surf").setup({
				default_engine = "DuckDuckGo",
				engines = {
					Elixir = { bang = "!ex", url = "https://hexdocs.pm/elixir/search.html?q=%s" },
				}
			})
		end,
	},
}
