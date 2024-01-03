return {
  "nvimtools/none-ls.nvim", -- configure formatters & linters
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local mason_null_ls = require("mason-null-ls")

    local null_ls = require("null-ls")

    local null_ls_utils = require("null-ls.utils")
    local null_ls_helpers = require("null-ls.helpers")
    local null_ls_logger = require("null-ls.logger")

    mason_null_ls.setup({
      ensure_installed = {
        "gofumpt",
        "goimports",
        "golangci-lint",
        "golines",
        "gospel",
        "hadolint",
        "nilaway",
        "prettierd",
        "stylua", -- lua formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- js linter
        "tflint",
        "shellcheck",
        "shfmt",
      },
    })

    -- for conciseness
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters
    local hover = null_ls.builtins.diagnostics -- to setup linters

    -- to setup format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local nilaway = {
      name = "nilaway",
      meta = {
        url = "https://github.com/uber-go/nilaway",
        description = "NilAway is a static analysis tool that seeks to help developers avoid nil panics in production by catching them at compile time rather than runtime",
      },
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      filetypes = { "go" },
      generator = null_ls.generator({
        command = "nilaway",
        to_stdin = true,
        from_stderr = false,
        ignore_stderr = true,
        multiple_files = true,
        cwd = null_ls_helpers.cache.by_bufnr(function(params)
          return null_ls_utils.root_pattern("go.mod")(params.bufname)
        end),
        args = { "run", "--fix=false", "--out-format=json" },
        format = "json",
        check_exit_code = function(code)
          return code <= 2
        end,
        on_output = function(params)
          local diags = {}
          if params.output["Report"] and params.output["Report"]["Error"] then
            null_ls_logger:warn(params.output["Report"]["Error"])
            return diags
          end
          local issues = params.output["Issues"]
          if type(issues) == "table" then
            for _, d in ipairs(issues) do
              table.insert(diags, {
                source = string.format("golangci-lint: %s", d.FromLinter),
                row = d.Pos.Line,
                col = d.Pos.Column,
                message = d.Text,
                severity = null_ls_helpers.diagnostics.severities["warning"],
                filename = null_ls_utils.path.join(params.cwd, d.Pos.Filename),
              })
            end
          end
          return diags
        end,
      }),
    }

    null_ls.register(nilaway)

    -- configure null_ls
    null_ls.setup({
      debounce = 150,
      save_after_format = false,

      -- add package.json as identifier for root (for typescript monorepos)
      root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
      -- setup formatters & linters
      sources = {
        --  to disable file types use
        --  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)

        -- Formatting
        formatting.prettierd.with({
          extra_filetypes = { "svelte" },
        }), -- js/ts formatter
        formatting.stylua, -- lua formatter
        formatting.isort,
        formatting.black,
        formatting.shfmt,
        formatting.gofmt,
        formatting.goimports,
        formatting.golines,

        -- Diagnosticts

        diagnostics.pylint,
        diagnostics.eslint_d.with({ -- js/ts linter
          condition = function(utils)
            return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
          end,
        }),
        diagnostics.shellcheck,
        diagnostics.golangci_lint,
        diagnostics.gospel,
        diagnostics.hadolint,
      },

      -- configure format on save
      on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                filter = function(client)
                  --  only use null-ls for formatting instead of lsp server
                  return client.name == "null-ls"
                end,
                bufnr = bufnr,
              })
            end,
          })
        end
      end,
    })
  end,
}
