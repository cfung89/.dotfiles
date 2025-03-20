vim.api.nvim_create_user_command("DownTerminal", function()
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

vim.api.nvim_create_user_command("SideTerminal", function()
	local current_win = vim.api.nvim_get_current_win()
	local current_height = vim.api.nvim_win_get_height(current_win)
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
	vim.cmd.wincmd("L")
	vim.api.nvim_win_set_height(0, current_height)
end, {})
