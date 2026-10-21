return {
  {
    "gbprod/yanky.nvim",
    opts = function(_, opts)
      opts.picker = vim.tbl_deep_extend("force", opts.picker or {}, {
        fzf = {
          winopts = {
            height = 0.8,
            width = 0.85,
            preview = {
              layout = "vertical",
              vertical = "up:40%",
            },
          },
        },
      })
    end,
  },
}
