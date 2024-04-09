local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    terraform = { "terraform_fmt" },
    tf = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },
    yaml = { "yamlfix" },
    python = { "ruff_fix", "ruff_format" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    -- ["*"] = { "codespell" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },

  formatters = {
    yamlfix = {
      env = {
        YAMLFIX_SEQUENCE_STYLE = "block_style",
        YAMLFIX_SECTION_WHITELINES = "1",
        YAMLFIX_WHITELINES = "1",
      },
    },
  },
}

require("conform").setup(options)
