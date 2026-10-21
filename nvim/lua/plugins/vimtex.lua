return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- core
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_view_method = "skim"

      -- no automatic UI interruptions
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_quickfix_open_on_error = 0

      -- avoid verbose output noise
      vim.g.vimtex_log_ignore = {
        "Underfull \\hbox",
        "Overfull \\hbox",
      }
    end,
  },
}
