local font = {
    icon = "",
    color = "#e15241",
    name = "Font"
}

local ruby = {
    icon = "󰴭",
    color = "#e15241",
    name = "Ruby"
}

local docker = {
    icon = "󰡨",
    color = "#458ee6",
    cterm_color = "68",
    name = "Docker",
}

local node = {
    icon = "󰎙",
    color = "#44883e",
    name = "Node"
}

local image = {
    icon = "󰈟",
    color = "#52a49a",
    name = "Image"
}

require("nvim-web-devicons").setup {
    strict = true,

    override_by_extension = {
        ["bmp"] = image,
        ["gif"] = image,
        ["jpg"] = image,
        ["jpeg"] = image,
        ["png"] = image,
        ["webp"] = image,
        ["ttf"] = font,
        ["otf"] = font,
        ["woff"] = font,
        ["woff2"] = font,
        ["eot"] = font,
        ["code-workspace"] = {
            icon = "󰨞",
            color = "#0098FF",
            name = "CodeWorkspace"
        },
        ["ts"] = {
            icon = "󰛦",
            color = "#519aba",
            name = "Typescript",
        },
        ["d.ts"] = {
            icon = "",
            color = "#519aba",
            name = "TypescriptTypes",
        },
        ["xsd"] = {
            icon = "󰗀",
            color = "#e37933",
            cterm_color = "166",
            name = "Xsd",
        },
        ["Dockerfile"] = docker,
        ["ru"] = ruby,
        ["rb"] = ruby,
        ["erb"] = ruby
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
        [".nvmrc"] = node,
        ["package.json"] = node,
        ["package-lock.json"] = node,
        ["Dockerfile"] = docker,
        ["Gemfile"] = ruby,
        ["Rakefile"] = ruby,
        [".editorconfig"] = {
            icon = "",
            color = "#ffffff",
            name = "Editorconfig"
        }
    }
}
