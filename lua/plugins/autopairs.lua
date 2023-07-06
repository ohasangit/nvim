return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
      check_ts = true,
      fast_wrap = {}
    },
}

--[[ Check if this still does something
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
--]]
