local monokai = require('monokai')
local palette = monokai.classic

monokai.setup {
    custom_hlgroups = {
        ['@include'] = {
            fg = palette.pink
        },
        ['Comment'] = {
            fg = palette.base6
        }
    },
}
