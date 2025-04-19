local client = vim.lsp.start_client {
	name = "golsp",
	cmd = { "/home/Cyrus/Github/golsp/bin/golsp" }
}

if not client then
	vim.notify "wrong client"
	return
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.lsp.buf_attach_client(0, client)
	end
})
