-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Options are automatically loaded before lazy.nvim startup
-- Default LazyVim options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Options are automatically loaded before lazy.nvim startup
-- Default LazyVim options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- single source of truth
vim.g.spell_conf = {
  dict = vim.fn.stdpath("config") .. "/spell/jargon.utf-8.add",
  vim_lang = "en_gb", -- vim: underscore, lowercase region
  ltex_langs = { "en-GB" }, -- LTeX: hyphen, uppercase region
  -- add "es" here if you start writing Spanish
}

opt.spelllang = { vim.g.spell_conf.vim_lang }
opt.spellfile = vim.g.spell_conf.dict
opt.spelloptions = "camel"
opt.spellsuggest = "best,9"
