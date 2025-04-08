local M = {}

function M.hello()
  print 'hello nigga'
end

function M.create_floating_window()
  if enter == nil then
    enter = false
  end

  local buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  local win = vim.api.nvim_open_win(buf, true, { relative = 'win', row = 3, col = 3, height = 5, width = 12 })
  -- local wow = vim.api.nvim_open_win
  vim.api.nvim_buf_call(buf, function()
    vim.cmd 'edit ~/.config/nvim/manousos_notes.md'
  end)

  return { buf = buf, win = win }
end

return M
