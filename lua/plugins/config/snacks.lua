return {

    ---@type snacks.Config
    opts = {
      input = {enabled=true},
      indent = {enabled=true},
      rename = {enabled=true},
      scope = {enabled=true},
      picker = {enabled=true},
      animate = {enabled=true},
      bigfile = {enabled=true},
      quickfile = {enabled=true},
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
    },

    init = function ()
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
}
