-- local monokai = require('monokai')
-- local palette = monokai.classic
--
-- monokai.setup {
--     custom_hlgroups = {
--         ['@include'] = {
--             fg = palette.pink
--         },
--         ['Comment'] = {
--             fg = palette.base6
--         }
--     },
-- }
--
-- require("catppuccin").setup({
--     flavour = "latte"
-- })

-- vim.g.colorscheme = "onedark"

-- require("onedark").setup()

-- vim.api.nvim_create_user_command(
--     'Colorscheme',
--     function(opts)
--         if opts.args == 'dark' then
--             vim.cmd('colorscheme tokyonight-night')
--         elseif opts.args == 'light' then
--             vim.cmd('colorscheme tokyonight-light')
--         else
--             vim.cmd('colorscheme ' .. opts.args)
--         end
--     end,
--     { nargs = 1 }
-- )

vim.cmd('colorscheme bluloco')
