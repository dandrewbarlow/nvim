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
  -- Both servers start themselves -- see helpers/repl.lua. Opening a .lisp or
  -- .scm buffer spawns one as a child of nvim, so it dies with nvim rather than
  -- lingering as a daemon, and anything already listening is reused instead.
  -- <leader>Lcc reconnects by hand if a server is restarted mid-session.
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
      -- unmaintained and won't install here, so use guile.
      --
      -- NOTE: this has to be the *socket* client, not scheme.stdio with
      -- command="guile". scheme.stdio is written around mit-scheme's output and
      -- unconditionally strips a trailing integer from every result
      -- (client/scheme/stdio.lua, the "%s+%d+%s*$" gsub in format-msg). guile
      -- answers "$1 = 3", so that gsub eats the 3 and you get "$1 =" back. no
      -- amount of prompt/value pattern config can recover it.
      vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
      vim.g["conjure#client#guile#socket#pipename"] = require("helpers.repl").guile.config.pipename
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

      -- guile returns *unspecified* for define/display/set! and friends, so
      -- conjure has no value to report and renders the inline result as
      -- "; Empty result". while writing scheme most top-level forms are
      -- defines, so that's noise on nearly every eval. drop the inline mark
      -- when there's no value -- the log still gets the printed output, which
      -- never reaches on-result anyway (parse-guile-result sends stray output
      -- straight to the log).
      local patched = false
      local function quiet_empty_guile_results()
        if patched then
          return
        end

        local ok, client = pcall(require, "conjure.client.guile.socket")
        if not ok or type(client["eval-str"]) ~= "function" then
          return
        end
        patched = true

        local eval_str = client["eval-str"]
        client["eval-str"] = function(opts)
          local on_result = opts["on-result"]
          if on_result then
            opts["on-result"] = function(result)
              if result and result:find("Empty result", 1, true) then
                return
              end
              return on_result(result)
            end
          end
          return eval_str(opts)
        end
      end

      -- start the REPL servers on demand, so opening a file is all it takes
      local repl = require("helpers.repl")
      local servers = { lisp = repl.swank, scheme = repl.guile }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lisp", "scheme" },
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if ft == "scheme" then
            quiet_empty_guile_results()
          end
          local server = servers[ft]
          if server then
            server.ensure()
          end
        end,
        desc = "start/attach a REPL server for conjure",
      })

      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function() repl.stop_all() end,
        desc = "tear down any REPL servers nvim started",
      })

      -- lazy loads this plugin *on* FileType, so the autocmd above misses the
      -- buffer that triggered the load
      if vim.bo.filetype == "scheme" then
        quiet_empty_guile_results()
      end
      local current = servers[vim.bo.filetype]
      if current then
        current.ensure()
      end
    end,
  },

}
