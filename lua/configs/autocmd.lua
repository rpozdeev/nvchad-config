function fn_docker_compose()
  local filename = vim.fn.expand "%:t"

  if filename == "docker-compose.yaml" then
    vim.bo.filetype = "yaml.docker-compose"
  end
end

vim.cmd [[au BufRead * lua fn_docker_compose()]]

-- Restore cursor position
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})
