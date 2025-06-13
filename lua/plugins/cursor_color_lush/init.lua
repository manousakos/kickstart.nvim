local M = {}

function M.cursor()
  local lush = require 'lush'
  local hsl = lush.hsl

  print 'Yo Hello'
  return {
    -- Set Cursor to be white text on black background
    Cursor { fg = hsl(0, 0, 100), bg = hsl(208, 90, 15) }, -- fg: white, bg: black
  }
end

return M
