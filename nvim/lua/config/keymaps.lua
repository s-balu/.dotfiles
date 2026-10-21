-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local function ltex_jump(dir)
  local diags = vim.tbl_filter(function(d)
    return d.source and d.source:match("LTeX")
  end, vim.diagnostic.get(0))

  if #diags == 0 then
    vim.notify("No LTeX diagnostics", vim.log.levels.INFO)
    return
  end

  table.sort(diags, function(a, b)
    if a.lnum ~= b.lnum then
      return a.lnum < b.lnum
    end
    return a.col < b.col
  end)

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  local target

  if dir > 0 then
    for _, d in ipairs(diags) do
      if d.lnum > row or (d.lnum == row and d.col > col) then
        target = d
        break
      end
    end
    target = target or diags[1] -- wrap
  else
    for i = #diags, 1, -1 do
      local d = diags[i]
      if d.lnum < row or (d.lnum == row and d.col < col) then
        target = d
        break
      end
    end
    target = target or diags[#diags]
  end

  vim.api.nvim_win_set_cursor(0, { target.lnum + 1, target.col })
  vim.diagnostic.open_float(nil, { scope = "cursor" })
end

vim.keymap.set("n", "]g", function()
  ltex_jump(1)
end, { desc = "Next grammar issue" })
vim.keymap.set("n", "[g", function()
  ltex_jump(-1)
end, { desc = "Prev grammar issue" })
