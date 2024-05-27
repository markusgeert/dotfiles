vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.splitright = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

vim.opt.statusline = ''
    .. '%#PmenuSel#'                               -- Set color 1
    .. " %{FugitiveStatusline()}"                  -- Current git branch
    .. ' %#StatusLine#'                            -- Set color 2, grayish
    .. " %f"                                       -- Current filename
    .. "%m"                                        -- Modified
    .. "%="                                        -- Align right
    .. " %y"                                       -- Filetype
    .. " %{&fileencoding?&fileencoding:&encoding}" -- Encoding
    .. " [%{&fileformat}]"                         -- File format
    .. " %l:%c"                                    -- Current line and column

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.cmd("language en_US")
