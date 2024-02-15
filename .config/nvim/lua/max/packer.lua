-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use 'Mofiqul/vscode.nvim'
    use 'tanvirtin/monokai.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }
    use "joshdick/onedark.vim"

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-context')
    use {
        'theprimeagen/harpoon',
        branch = "harpoon2",
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use('mbbill/undotree')

    use('tpope/vim-fugitive')
    use('tpope/vim-sleuth')
    use('tpope/vim-rails')

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use('JoosepAlviste/nvim-ts-context-commentstring')

    use('tpope/vim-vinegar')
    use('prichrd/netrw.nvim')
    use('nvim-tree/nvim-web-devicons')

    use {
        "pmizio/typescript-tools.nvim",
        requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { 'simrat39/rust-tools.nvim' },
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }

    use 'jose-elias-alvarez/null-ls.nvim'
    use 'jay-babu/mason-null-ls.nvim'

    use 'github/copilot.vim'
end)
