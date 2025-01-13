vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.encoding = "utf-8"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.list = true -- show tab characters and trailing whitespace

vim.opt.wrap = true

vim.opt.termguicolors = true

vim.opt.mouse = ""

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- unless capital letter in search

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.opt.swapfile = true
vim.opt.termguicolors = true -- for bufferline

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
