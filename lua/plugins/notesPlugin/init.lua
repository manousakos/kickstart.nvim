local M = {}

function M.hello()
  print 'hello nigga'
end

Note_buf = nil

function M.create_floating_window()
  if Note_buf == nil then
    Note_buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  local buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  -- vim.api.nvim_buf_call(buf, function()
  --   vim.cmd 'edit ~/.config/nvim/manousos_notes.md'
  -- end)
  local win = vim.api.nvim_open_win(buf, true, { relative = 'win', row = 0, col = 0, height = 30, width = 100, border = 'rounded' })

  -- local wow = vim.api.nvim_open_win

  return { buf = buf, win = win }
end

return M
