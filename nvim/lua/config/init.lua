require("config.options")
require("config.keymaps")
require("config.lazy_init")

require('lazy').setup({
	spec = 'config.plugins',
	checker = {
		enabled = true,
		notify = true
	}
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

vim.api.nvim_create_user_command("SmallTerminal", function()
	local current_win = vim.api.nvim_get_current_win()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "terminal" then
			vim.api.nvim_win_close(win, true)
			return
		end
	end

	-- Else, open a new terminal
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 8)
end, {})
