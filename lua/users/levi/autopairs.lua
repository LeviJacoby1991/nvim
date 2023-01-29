local autopairs = require('nvim-autopairs')

if not status_ok then
  return
end

autopairs.setup{
}

local cmp_autopairs = require "nvim-autopairs.completition.cmp"
local cmp = require('cmp')

cmp.event:on(
  "confirm_done", 
  cmp_autopairs.on_confirm_done()
)
