
-- want to be able to quickly touch digital grass
-- also, so far, seems kind of buggy and slow
local ai = true

local plugin = require('plugins.config.avante')

-- using avante as my AI plugin
if ai then
  return plugin
else
  return {}
end
