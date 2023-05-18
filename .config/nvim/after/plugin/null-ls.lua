local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettierd
            .with({
                prefer_local = "node_modules/.bin",
                extra_filetypes = { "vue", "json" },
            }),
    }
})
