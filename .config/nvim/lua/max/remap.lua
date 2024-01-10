vim.g.mapleader = " "

-- Exit current buffer
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>E", function() vim.cmd.Ex(vim.fn.getcwd()) end)
vim.keymap.set("n", "<leader>w", vim.cmd.write)
vim.keymap.set("n", "<leader>o", "<C-w>o")

-- Go to normal mode using kj
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("v", "kj", "<Esc>")
vim.keymap.set("c", "kj", "<C-C>")
vim.keymap.set("t", "kj", "<C-\\><C-n>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- 'Drag' lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Center after movement
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without yanking
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Yank to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

local function format(buf)
    local null_ls_sources = require("null-ls.sources")
    local filetype = vim.bo[buf].filetype

    local has_null_ls = #null_ls_sources.get_available(filetype, 'NULL_LS_FORMATTING') > 0

    vim.lsp.buf.format({
        timeout = 2000,
        bufnr = buf,
        filter = function(client)
            if has_null_ls then
                return client.name == "null-ls"
            end

            return true
        end
    })
end

vim.keymap.set("n", "<leader>f", function() format(vim.fn.bufnr()) end)

-- Format on write
vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = "*", callback = function() format(vim.fn.bufnr()) end })

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>")
vim.keymap.set("n", "<leader>vc", "<cmd>e ~/.config/nvim<CR>");

vim.keymap.set("n", "<F10>", "<cmd>TSHighlightCapturesUnderCursor<CR>")

-- Remove default mapping of <c-l> by Netrw
local netrw_mappings = vim.api.nvim_create_augroup('netrw_mappings', { clear = true })
vim.api.nvim_create_autocmd({ 'filetype' }, {
    pattern = "netrw",
    group = netrw_mappings,
    command = "silent! nunmap <buffer> <c-l>"
})

local function changeDir()
    if (vim.bo.filetype == "netrw") then
        vim.cmd("lcd %")
    else
        vim.cmd("lcd %:h")
    end
end

vim.keymap.set("n", "<leader>cd", changeDir)

vim.wo.foldlevel = 99
