local M = {}

function M.setup()
  local status, autotag = pcall(require, "nvim-ts-autotag")
  if (not status) then return end

  autotag.setup({})
end

return M
