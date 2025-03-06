return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
			vim.keymap.set("n", "<leader>fg", ":Telescope git_files<cr>")
			vim.keymap.set("n", "<leader>fp", ":Telescope live_grep<cr>")
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fc", function()
				require("telescope.builtin").find_files {
					cwd = vim.fn.stdpath("config")
				}
			end)

			-- vim.keymap.set("n", "<leader>fs", function()
			-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
			-- end)
			-- vim.keymap.set("n", "<leader>fws", function()
			-- 	local word = vim.fn.expand("<cword>")
			-- 	builtin.grep_string({ search = word })
			-- end)
			-- vim.keymap.set("n", "<leader>fWs", function()
			-- 	local word = vim.fn.expand("<cWORD>")
			-- 	builtin.grep_string({ search = word })
			-- end)
		end,
	},
}
