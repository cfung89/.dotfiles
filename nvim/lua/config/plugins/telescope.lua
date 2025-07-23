return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- extremely slow
			require("telescope").setup({
				defaults = { file_ignore_patterns = { "node%_modules/.*", "%.git/.*" } },
			})

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({ hidden = true, no_ignore = true })
			end)
			vim.keymap.set("n", "<leader>fd", function()
				builtin.find_files({ hidden = true })
			end)
			-- vim.keymap.set("n", "<leader>fe", function()
			-- 	builtin.fold[({ hidden = true })
			-- end)
			vim.keymap.set("n", "<leader>fp", function()
				builtin.live_grep({ hidden = true })
			end)
			vim.keymap.set("n", "<leader>fh", builtin.help_tags)
			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({
					cwd = os.getenv("HOME") .. "/Documents/notes",
					hidden = true,
					no_ignore = false,
				})
			end)
			vim.keymap.set("n", "<leader>fc", function()
				builtin.find_files({
					cwd = vim.fn.stdpath("config"),
					hidden = true,
					no_ignore = false, -- do not show gitignore
				})
			end)
			vim.keymap.set("n", "<leader>fm", builtin.man_pages)

			-- grep_string
			vim.keymap.set("n", "<leader>fs", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end)
			vim.keymap.set("v", "<leader>fs", function()
				vim.cmd('noau normal! "vy"')
				local text = vim.fn.getreg("v")
				vim.fn.setreg("v", {})

				text = string.gsub(text, "\n", "")
				builtin.grep_string({ search = text })
			end)
			-- search current word
			vim.keymap.set("n", "<leader>fws", function()
				local word = vim.fn.expand("<cword>")
				builtin.grep_string({ search = word })
			end)
			-- search current outer word
			vim.keymap.set("n", "<leader>fas", function()
				local word = vim.fn.expand("<cWORD>")
				builtin.grep_string({ search = word })
			end)

			require("config.telescope.multigrep").setup()
			-- require("nvim.lua.config.telescope.multigrep").setup()
		end,
	},
}
