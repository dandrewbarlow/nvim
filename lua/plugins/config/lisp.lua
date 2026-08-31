-- lisp.lua
-- a collection of lisp related plugins
return {

  -- easy parentheses infer
  {"gpanders/nvim-parinfer"},

  -- Interactive evaluation / REPL, over Swank for Common Lisp.
  --
  -- NOTE: there is no Common Lisp LSP worth chasing -- mason has none, and none
  -- of nvim-lspconfig's ~400 server configs cover CL. The language never went
  -- the LSP route because the image-based Swank protocol predates it and does
  -- strictly more (live image introspection, not just static analysis). So we
  -- talk to Swank directly rather than pretending it's an LSP.
  --
  -- Neither language needs a REPL started by hand. Scheme is stdio, so conjure
  -- spawns chicken itself; common lisp needs a swank server, which
  -- helpers/swank.lua starts as a child of nvim on the first .lisp buffer (and
  -- reuses anything already listening). Both die with nvim, no daemons.
  -- <leader>lcc reconnects by hand if a server is restarted mid-session.
  {
    "Olical/conjure",
    ft = { "lisp", "clojure", "fennel", "scheme", "racket", "janet" },
    dependencies = {
      -- feeds conjure's live-image completions into nvim-cmp
      "PaterJason/cmp-conjure",
    },

    -- vim.g settings must be in init(), conjure reads them as it loads
    init = function()
      -- maplocalleader is <Space> (see globals.lua), same as mapleader, so
      -- conjure's default <localleader> prefix would shadow <leader>e (neotree),
      -- <leader>r (run), <leader>s (session) and <leader>c. Give it its own
      -- prefix instead -- see the [L]isp group in which_key.lua.
      --
      -- <leader>l is shared with the LSP maps on purpose. There's no common
      -- lisp LSP to attach, and the two sets are disjoint at the second key
      -- anyway -- LSP takes I/a/d/i/r, conjure takes E/c/e/g/l -- so nothing
      -- shadows anything and there's no timeoutlen ambiguity either.
      vim.g["conjure#mapping#prefix"] = "<leader>l"

      -- show eval results inline as virtual text, plus the floating HUD
      vim.g["conjure#eval#inline_results"] = true
      vim.g["conjure#log#hud#anchor"] = "SE"
      vim.g["conjure#log#hud#width"] = 0.42

      -- completions come through nvim-cmp below, don't also hijack omnifunc
      vim.g["conjure#completion#omnifunc"] = false

      -- conjure's scheme client defaults to mit-scheme, which is effectively
      -- unmaintained and won't install here, so run chicken over stdio.
      --
      -- NOTE: the binary is chicken-csi, NOT the "csi" the conjure wiki names.
      -- dotnet-sdk also ships a /usr/bin/csi (the C# interactive compiler) and
      -- it wins on $PATH here, so plain "csi" starts the wrong repl entirely.
      --
      -- chicken prints values bare on their own line, so there's no value
      -- prefix to strip -- false disables that step. the prompt counts up
      -- (#;1>, #;2> ...) and doesn't advance on error.
      vim.g["conjure#filetype#scheme"] = "conjure.client.scheme.stdio"
      vim.g["conjure#client#scheme#stdio#command"] = "chicken-csi -:c"
      vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "\n?#;%d+> "
      vim.g["conjure#client#scheme#stdio#value_prefix_pattern"] = false
    end,

    config = function()
      -- register the conjure source for lisp-ish buffers only, so the global
      -- cmp sources in config/cmp.lua stay untouched
      require("cmp").setup.filetype(
        { "lisp", "clojure", "fennel", "scheme", "racket", "janet" },
        {
          sources = {
            { name = "conjure" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
          },
        }
      )

      -- conjure's scheme client carries one more mit-scheme-ism: format-msg
      -- strips a trailing integer off every result (the "%s+%d+%s*$" gsub in
      -- client/scheme/stdio.lua). with chicken that silently eats the value
      -- whenever output ends in a newline before it --
      --   (begin (display "x") (newline) 42)
      -- logs "x" and loses the 42 from both the log and the inline result.
      -- swap in the same logic without the destructive strip. assumes
      -- value_prefix_pattern is false, which it is (set above).
      local patched = false
      local function fix_scheme_results()
        if patched then
          return
        end

        local ok, client = pcall(require, "conjure.client.scheme.stdio")
        if not ok or type(client["format-msg"]) ~= "function" then
          return
        end
        patched = true

        client["format-msg"] = function(msg)
          local out = string.gsub(msg and msg.out or "", "^%s*", "")
          local lines = {}
          for _, line in ipairs(vim.split(out, "\n")) do
            if line ~= "" then
              table.insert(lines, line)
            end
          end
          return lines
        end
      end

      -- start swank on demand, so opening a .lisp file is all it takes
      local swank = require("helpers.swank")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lisp", "scheme" },
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if ft == "scheme" then
            fix_scheme_results()
          elseif ft == "lisp" then
            swank.ensure()
          end
        end,
        desc = "prepare the REPL for conjure",
      })

      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function() swank.stop() end,
        desc = "tear down the swank server nvim started",
      })

      -- lazy loads this plugin *on* FileType, so the autocmd above misses the
      -- buffer that triggered the load
      if vim.bo.filetype == "scheme" then
        fix_scheme_results()
      elseif vim.bo.filetype == "lisp" then
        swank.ensure()
      end
    end,
  },

}
