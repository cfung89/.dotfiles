return {
	-- Markdown Preview
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function(plugin)
			if vim.fn.executable("npx") then
				vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
			else
				vim.cmd([[Lazy load markdown-preview.nvim]])
				vim.fn["mkdp#util#install"]()
			end
		end,
		init = function()
			if vim.fn.executable("npx") then
				vim.g.mkdp_filetypes = { "markdown" }
			end
		end,
		config = function()
			vim.keymap.set("n", "<leader>md", ":MarkdownPreviewToggle<cr>")
			-- vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<cr>")
			-- vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<cr>")

			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_auto_close = 0
			vim.g.mkdp_refresh_slow = 1
			vim.g.mkdp_command_for_global = 1
			vim.g.mkdp_open_to_the_world = 0
			vim.g.mkdp_open_ip = ""
			vim.g.mkdp_browser = "/bin/firefox"
			vim.g.mkdp_echo_preview_url = 1
			vim.g.mkdp_browserfunc = ""
		end,
	},
}
