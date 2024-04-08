require "nvchad.options"

local opt = vim.opt

opt.relativenumber = true

opt.scrolloff = 10

opt.spelllang = { "ru_ru", "en_us" }
opt.spell = true

opt.cursorline = true
opt.colorcolumn = "120"

opt.swapfile = false

opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
