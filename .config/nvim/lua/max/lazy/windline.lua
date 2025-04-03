return {
    "windwp/windline.nvim",

    config = function()
        require("wlsample.airline")

        local windline = require('windline')
        local utils = require('windline.utils')
        local state = windline.state

        local bufnr = vim.fn.winbufnr(vim.g.statusline_winid)

        opt = {}
        format = '%s'

        local git_dict = state.comp.git_dict
            or utils.buf_get_var(bufnr, 'gitsigns_status_dict')
        print(bufnr)
        print(git_dict)
        if git_dict and git_dict.head then
            local value = git_dict.added or 0
            print(value)
            if value > 0 or value == 0 and opt.show_zero == true then
                print(value)
                print(string.format(format, value))
            end
        end
    end,
}
