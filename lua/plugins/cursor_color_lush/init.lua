local M = {}

function M.cursor()
  local lush = require 'lush'
  local hsl = lush.hsl

  print 'Yo Hello'

  -- lush() must wrap your highlight group table
  return lush(function()
    return {
      Cursor { fg = hsl(0, 0, 100), bg = hsl(208, 90, 15) }, -- white on blue-ish
    }
  end)
end

return M
