local client = vim.lsp.start_client({
	name = "golspx",
	cmd = { "/home/cyrus/Github/golspx/bin/golspx" }
})

if not client then
	vim.notify("Error: golspx")
	vim.print(client)
	return
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.lsp.buf_attach_client(0, client)
	end,
})
