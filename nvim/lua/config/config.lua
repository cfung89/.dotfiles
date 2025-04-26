vim.api.nvim_create_user_command("W", function()
	vim.cmd("w")
end, {
	desc = "Save file",
})

vim.api.nvim_create_user_command("Wq", function()
	vim.cmd("wq")
end, {
	desc = "Save and quit file",
})

vim.api.nvim_create_user_command("Q", function()
	vim.cmd("q")
end, {
	desc = "Save file",
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

local friendly = 0

vim.api.nvim_create_user_command("Friendly",
	function()
		if friendly == 1 then
			friendly = 0
			vim.cmd("set mouse=r")
		else
			friendly = 1
			vim.cmd("set mouse=a")
			vim.cmd("startinsert")
		end
	end,
	{ desc = "Toggle floating terminal" })
