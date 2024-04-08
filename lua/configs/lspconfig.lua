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
  -- pyright = {
  --   settings = {
  --     python = {
  --       analysis = {
  --         autoSearchPaths = true,
  --         typeCheckingMode = "basic",
  --       },
  --     },
  --   },
  -- },
}

configs.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  require("lspconfig")[name].setup(opts)
end
