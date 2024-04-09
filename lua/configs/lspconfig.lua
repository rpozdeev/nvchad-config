local configs = require "nvchad.configs.lspconfig"

local servers = {
  terraformls = {},
  yamlls = {},
  helm_ls = {
    settings = {
      ["helm-ls"] = {
        yamlls = {
          path = "yaml-language-server",
        },
      },
    },
  },
  pyright = {
    settings = {
      pyright = {
        -- Using Ruff's import organizer
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          -- Ignore all files for analysis to exclusively use Ruff for linting
          ignore = { "*" },
        },
      },
    },
  },
}

configs.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  if name == "ruff_lsp" then
    opts.on_attach.server_capabilities.hoverProvider = false
  end

  require("lspconfig")[name].setup(opts)
end

vim.diagnostic.config {
  virtual_text = false,
}

require("cmp").setup {
  sources = {
    { name = "path" },
    { name = "codeium" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
  },
}
