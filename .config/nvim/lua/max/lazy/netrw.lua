return {
    "prichrd/netrw.nvim",

    config = function()
        require("netrw").setup {
            icons = {
                file = ""
            },
            use_devicons = true,
            mappings = {
                ['D'] = function(payload)
                    local filepath = payload["dir"] .. "/" .. payload["node"]

                    vim.fn.system("trash " .. filepath)

                    vim.cmd("e!")
                end
            }
        }
    end
}
