require("nvim-web-devicons").setup {
    strict = true,

    override_by_extension = {
        ["code\\-workspace"] = {
            icon = "󰨞",
            color = "#0098FF",
            name = "CodeWorkspace"
        },
        ["ts"] = {
            color = "#519aba",
            name = "Typescript",
            icon = "󰛦"
        },
        ["d.ts"] = {
            color = "#519aba",
            name = "TypescriptTypes",
            icon = ""
        },
    },

    override_by_filename = {
        [".firebaserc"] = {
            icon = "󰥧",
            color = "#FFCA28",
            name = "Firebaserc"
        },
        [".gitignore"] = {
            icon = "󰊢",
            color = "#f14e32",
            name = "Gitignore"
        },
        [".nvmrc"] = {
            icon = "󰎙",
            color = "#44883e",
            name = "Nvmrc"
        },
        ["package.json"] = {
            icon = "󰎙",
            color = "#44883e",
            name = "Package"
        },
        ["package-lock.json"] = {
            icon = "󰎙",
            color = "#44883e",
            name = "PackageLock"
        }
    }
}
