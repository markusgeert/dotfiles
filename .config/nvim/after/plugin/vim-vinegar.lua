local hiddenPaths = {
    '^.DS_Store',
}

if vim.g.netrw_list_hide == nil then vim.g.netrw_list_hide = "" end
vim.g.netrw_list_hide = vim.g.netrw_list_hide .. ',' .. table.concat(hiddenPaths, ',')
