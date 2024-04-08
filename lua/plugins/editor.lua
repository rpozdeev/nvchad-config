return {
  -- { "MunifTanjim/nui.nvim", lazy = true },
  -- {
  --   "stevearc/dressing.nvim",
  --   opts = {},
  -- },
  {
    "stevearc/oil.nvim",
    event = "VimEnter",
    opts = {
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>Oil --float<cr>" },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
          -- stylua: ignore
          keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in Files (Spectre)" },
          },
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local actions = require "telescope.actions"

      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-x>"] = actions.delete_buffer,
            },
          },
          file_ignore_patterns = {
            "node_modules",
            "yarn.lock",
            ".git",
            ".sl",
            "_build",
            ".next",
            ".idea",
            ".terraform",
          },
          hidden = true,
        },
      }
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "VimEnter",
    dependencies = "kevinhwang91/promise-async",
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open All Folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close All Folds",
      },
      {
        "zr",
        function()
          require("ufo").openFoldsExceptKinds()
        end,
        desc = "Open Except Kids",
      },
      {
        "zm",
        function()
          require("ufo").closeFoldsWith()
        end,
        desc = "Close Folds",
      },
    },
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("local_detach_ufo", { clear = true }),
        pattern = opts.filetype_exclude,
        callback = function()
          require("ufo").detach()
        end,
      })

      vim.opt.foldcolumn = "0" -- '0' is not bad
      -- vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      -- vim.opt.foldlevelstart = 99
      -- vim.opt.foldenable = true
      -- vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      require("ufo").setup(opts)
    end,
  },
  -- {
  --   "luukvbaal/statuscol.nvim",
  --   opts = function()
  --     local builtin = require "statuscol.builtin"
  --     return {
  --   --     setopt = true,
  --   --     -- override the default list of segments with:
  --   --     -- number-less fold indicator, then signs, then line number & separator
  --   --     segments = {
  --   --       { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
  --   --       { text = { "%s" }, click = "v:lua.ScSa" },
  --   --       {
  --   --         text = { builtin.lnumfunc, " " },
  --   --         condition = { true, builtin.not_empty },
  --   --         click = "v:lua.ScLa",
  --   --       },
  --   --     },
  --     }
  --   end,
  -- },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd [[do FileType]]
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    opts = function()
      local opts = {}
      for _, ft in ipairs { "markdown", "norg", "rmd", "org" } do
        opts[ft] = {
          headline_highlights = {},
          -- disable bullets for now. See https://github.com/lukas-reineke/headlines.nvim/issues/66
          bullets = {},
        }
        for i = 1, 6 do
          local hl = "Headline" .. i
          vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
          table.insert(opts[ft].headline_highlights, hl)
        end
      end
      return opts
    end,
    ft = { "markdown", "norg", "rmd", "org" },
    config = function(_, opts)
      -- PERF: schedule to prevent headlines slowing down opening a file
      vim.schedule(function()
        require("headlines").setup(opts)
        require("headlines").refresh()
      end)
    end,
  },
}
