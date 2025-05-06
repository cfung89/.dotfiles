vim.keymap.set("n", "m", function()
	local get = vim.fn.getchar()
	local char
	if type(get) == "number" then
		char = string.char(get)
	else
		return
	end
	local buf = vim.api.nvim_get_current_buf()
	local lnum = vim.fn.line('.')
	vim.api.nvim_buf_set_mark(buf, char, lnum, 1, {})
	vim.print("Created mark '" .. char .. "'")
end, { desc = "Create mark." })

vim.keymap.set("n", "dm", function()
	local get = vim.fn.getchar()
	local char
	if type(get) == "number" then
		char = string.char(get)
	else
		return
	end
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_del_mark(buf, char)
	vim.print("Deleted mark '" .. char .. "'")
end, { desc = "Delete mark." })
