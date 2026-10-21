-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "plaintex", "bib", "markdown" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_gb" -- or en_us
    vim.opt_local.spelloptions = "camel" -- splits CamelCase words
  end,
})

-- one shared personal dictionary
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/jargon.utf-8.add"

-- Autocmds are automatically loaded on the VeryLazy event
-- Default LazyVim autocmds: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "plaintex", "bib", "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    -- spelllang/spellfile/spelloptions are inherited from the globals
  end,
})
