return {
    "github/copilot.vim",

    config = function()
        vim.api.nvim_set_var("copilot_filetypes", {
            ["dap-repl"] = false,
        })
    end
}
