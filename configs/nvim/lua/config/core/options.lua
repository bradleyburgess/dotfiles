local opt = vim.opt

-- options
opt.number = true -- absolute line numbers in the gutter
opt.ignorecase = true -- case insensitive search
opt.smartcase = true -- detect uppercase in search
opt.hlsearch = true -- highlight other search results
opt.cursorline = true -- highlight current line
opt.wrap = false -- don't wrap lines
opt.tabstop = 2 -- 2 spaces for tab
opt.shiftwidth = 2 -- indent lines by 2 spaces
opt.expandtab = true -- expand tabs to spaces

vim.g.mapleader = ' ' -- set space as leader key
