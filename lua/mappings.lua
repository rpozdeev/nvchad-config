require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr><esc>")

map({ "n" }, "<Esc>", "<cmd>nohlsearch<CR>")

map({ "n" }, "<left>", '<cmd>echo "Use h to move!!"<CR>')
map({ "n" }, "<right>", '<cmd>echo "Use l to move!!"<CR>')
map({ "n" }, "<up>", '<cmd>echo "Use k to move!!"<CR>')
map({ "n" }, "<down>", '<cmd>echo "Use j to move!!"<CR>')

map({ "v" }, "<", "<gv")
map({ "v" }, ">", ">gv")

map("n", "<leader>e", "<cmd>Oil --float<cr>", { desc = "Oil Focus window" })

map({ "n" }, "dm", "<cmd>lua require('neotest').run.run()<cr>", { desc = "Test Method" })
map({ "n" }, "dM", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", { desc = "Test Method DAP" })
map({ "n" }, "df", "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", { desc = "Test Class" })
map(
  { "n" },
  "dF",
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
  { desc = "Test Class DAP" }
)
map({ "n" }, "dS", "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = "Test Summary" })
