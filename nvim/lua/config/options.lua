local set = vim.opt

set.nu = true
set.relativenumber = true
set.encoding = "utf-8"

set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.smartindent = true
set.autoindent = true
set.list = true -- show tab characters and trailing whitespace

set.wrap = true

set.termguicolors = true

set.mouse = ""

set.hlsearch = false
set.incsearch = true
set.ignorecase = true -- ignore case when searching
set.smartcase = true  -- unless capital letter in search

set.scrolloff = 8
set.sidescrolloff = 8

set.updatetime = 50
set.colorcolumn = "80"

set.swapfile = true
set.termguicolors = true -- for bufferline


set.signcolumn = "yes:1"

vim.cmd([[autocmd FileType * set formatoptions-=ro]])
