require("config.options")
require("config.keymaps")
require("config.lazy_init")

require('lazy').setup({
	spec = 'config.plugins',
	change_detection = { notify = false },
	checker = { enabled = true, notify = false }
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})
