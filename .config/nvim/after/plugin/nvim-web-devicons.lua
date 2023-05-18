require("nvim-web-devicons").setup {
    strict = true,

    override_by_filename = {
        [".firebaserc"] = {
            icon = "󰥧",
            color = "#FFCA28",
            name = "Firebaserc"
        },
        -- ["package.json"] = {
        --     icon = "󰎙",
        --     color = "#44883e",
        --     name = "Nodejs"
        -- }
    }
}
