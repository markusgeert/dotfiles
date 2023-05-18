local insideGitDir = string.gsub(vim.fn.system('git rev-parse --is-inside-work-tree'), '\n', '')

if insideGitDir == 'true' then
    -- Adapted from: https://github.com/neovim/neovim/blob/master/runtime/autoload/netrw_gitignore.vim
    local gitignores = vim.fn.system('git ls-files --other --ignored --exclude-standard --directory')

    if gitignores ~= '' then
        local ignoredFilesIterator = string.gmatch(gitignores, "[^\n|\r]+")

        local ignoredFiles = {}

        for i in ignoredFilesIterator do
            table.insert(ignoredFiles, '\\(' .. i .. '\\)')
        end

        local ignoredPattern = '"' .. table.concat(ignoredFiles, '\\|') .. '"'

        vim.cmd.syn({ args = { 'match', 'netrwGitignore', ignoredPattern } })
        vim.cmd.hi('default link netrwGitignore netrwComment')
    end
end
