local M = {}

function M.create_floating_term()
  if Note_buf == nil then
    Note_buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  local buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  local win = vim.api.nvim_open_win(buf, true, { relative = 'win', row = 0, col = 0, height = 10, width = 50, border = 'rounded' })
  local term = vim.api.nvim_open_term(buf, {})
  -- local wow = vim.api.nvim_open_win

  return { buf = buf, win = win }
end

return M
