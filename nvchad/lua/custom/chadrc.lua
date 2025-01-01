---@type ChadrcConfig 
 local M = {}
 M.ui = {theme = 'gruvbox'}
 M.plugins = "custom.plugins"
 M.mappings = require "custom.mappings"

-- -- Set transparency for Neovim
-- vim.cmd[[ hi Normal guibg=NONE ctermbg=NONE ]]
-- vim.cmd[[ hi NonText guibg=NONE ctermbg=NONE ]]
-- vim.cmd[[ hi LineNr guibg=NONE ctermbg=NONE ]]
-- vim.cmd[[ hi VertSplit guibg=NONE ctermbg=NONE ]]
-- vim.cmd[[ hi StatusLine guibg=NONE ctermbg=NONE ]]
-- vim.cmd[[ hi StatusLineNC guibg=NONE ctermbg=NONE ]]
--
-- -- Set transparency level (adjust the value as needed)
-- vim.o.winblend = 80

-- Icons for break points
vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

vim.filetype.add({
    extension = {
        templ = "templ",
    },
})

return M
