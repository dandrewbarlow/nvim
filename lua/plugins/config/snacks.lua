-- just to simplify the process
local enabled = {enabled = true}

local M = {}

---@type snacks.Config
M.opts = {
  input = enabled,
  image = enabled,
  indent = enabled,
  rename = enabled,
  scope = enabled,
  picker = enabled,
  animate = enabled,
  bigfile = enabled,
  quickfile = enabled,
  ---
  ---@class snacks.scroll.Config
  ---@field animate snacks.animate.Config|{}
  ---@field animate_repeat snacks.animate.Config|{}|{delay:number}
  scroll = {
    enabled=true,
    animate = {
      easing = "outCubic"
    }
  },
}

M.init = function ()
  -- oil file renames
  vim.api.nvim_create_autocmd("User", {
    pattern = "OilActionsPost",
    callback = function(event)
        if event.data.actions.type == "move" then
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
    end,
  })
end

return M
