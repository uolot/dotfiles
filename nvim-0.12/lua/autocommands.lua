-- Fix <Esc> handling when kitty protocol enabled
-- https://github.com/neovim/neovim/issues/32143#issuecomment-3398950211

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    io.stdout:write("\027[>1u")
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    io.stdout:write("\027[<1u")
  end,
})


