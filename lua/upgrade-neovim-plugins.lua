#!/usr/bin/env lua 
-- This is only for upgrading both Vim-Plug and Mason plugins concurrently.
-- Usage: nvim +'lua require("upgrade-neovim-plugins")'
-- For Coc, see `upgrade`

local plug_done = false
local mason_done = false

local function maybe_quit()
  if plug_done and mason_done then
    vim.cmd("qa")
  end
end

vim.api.nvim_create_autocmd("User", {
    pattern = "MasonUpdateAllComplete",
    callback = function()
        print('mason-update-all has finished')
        mason_done = true
        maybe_quit()
    end,
})

-- Kick off the async Mason update.
vim.cmd("MasonUpdate")
-- https://github.com/RubixDev/mason-update-all
vim.cmd("MasonUpdateAll")

-- Run Vim-Plug updates.
vim.cmd([[
    PlugUpdate
    PlugClean!
    PlugUpgrade
]])

-- These are synchronous, so if we got here they're finished.
plug_done = true
maybe_quit()

print("Vim-Plug updates finished, waiting for Mason updates to finish…")
