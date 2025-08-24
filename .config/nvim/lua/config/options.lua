vim.fn.mkdir(vim.fn.stdpath("data") .. "/site/spell", "p")

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
vim.opt.shell = 'zsh'
vim.opt.showmode = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.breakindent = true
vim.opt.signcolumn = 'yes'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.cursorline = true
vim.opt.scrolloff = 15

vim.opt.foldmethod = 'indent'
vim.opt.foldlevelstart = 99

vim.opt.mouse = 'a'

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us", "pt_br" }
  end,
})
