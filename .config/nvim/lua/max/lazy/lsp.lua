return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
            ['<Tab>'] = vim.NIL,
            ['<S-Tab>'] = vim.NIL,
        })
        cmp.setup({
            mapping = cmp_mappings,
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
            }, {
                { name = "buffer" },
            }),
        })


        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "biome",
                "tsserver",
                "volar",
                "efm",
                "eslint",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["efm"] = function()
                    local util = require 'lspconfig.util'

                    local prettier_d = {
                        formatCommand =
                        'prettierd ${--config-precedence:configPrecedence} ${--tab-width:tabWidth} ${--single-quote:singleQuote} ${--trailing-comma:trailingComma} --stdin-filepath "${INPUT}"',
                        formatStdin = true,
                    }

                    local lspconfig = require("lspconfig")
                    lspconfig.efm.setup {
                        init_options = { documentFormatting = true },
                        filetypes = { "javascript", "typescript", "vue", "html", "json", "jsonc" },
                        root_dir = util.root_pattern(".prettierrc"),
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            local function find_root_marker(filename)
                                local current_dir = vim.fn.getcwd()
                                while current_dir ~= "/" do
                                    if vim.fn.glob(current_dir .. "/" .. filename) ~= "" then
                                        return true
                                    end
                                    current_dir = vim.fn.fnamemodify(current_dir, ":h")
                                end
                                return false
                            end

                            if find_root_marker("biome.json") then
                                client.stop()
                                return
                            end
                        end,
                        settings = {
                            rootMarkers = { ".prettierrc" },
                            languages = {
                                javascript = { prettier_d },
                                typescript = { prettier_d },
                                vue = { prettier_d },
                                html = { prettier_d },
                                json = { prettier_d },
                                jsonc = { prettier_d },
                            }
                        }
                    }
                end,

                ["tsserver"] = function()
                    local mason_registry = require('mason-registry')
                    local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
                        '/node_modules/@vue/language-server'

                    local lspconfig = require("lspconfig")
                    lspconfig.tsserver.setup {
                        init_options = {
                            plugins = {
                                {
                                    name = "@vue/typescript-plugin",
                                    location = vue_language_server_path,
                                    languages = { "vue" },
                                },
                            },
                        },
                        handlers = {
                            -- Don't show 'convert to esm' warning
                            ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
                                if result.diagnostics ~= nil then
                                    local idx = 1
                                    while idx <= #result.diagnostics do
                                        if result.diagnostics[idx].code == 80001 then
                                            table.remove(result.diagnostics, idx)
                                        else
                                            idx = idx + 1
                                        end
                                    end
                                end
                                vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
                            end,
                        },
                        filetypes = {
                            "javascript",
                            "typescript",
                            "vue",
                        },
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}

-- local lsp = require('lsp-zero')
--
-- lsp.preset('recommended')
--
-- lsp.ensure_installed({
--     'eslint',
--     'lua_ls',
--     'rust_analyzer',
--     'solargraph',
--     'pyright',
-- })
--
-- local cmp = require('cmp')
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--     ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--     ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--     ['<C-Space'] = cmp.mapping.complete(),
--     ['<Tab>'] = vim.NIL,
--     ['<S-Tab>'] = vim.NIL,
-- })
--
-- lsp.set_preferences({
--     sign_icons = {}
-- })
--
-- lsp.setup_nvim_cmp({
--     mapping = cmp_mappings
-- })
--
-- lsp.on_attach(function(_, bufnr)
--     local opts = { buffer = bufnr, remap = false }
--
--     vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--     vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
--     vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--     vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--     vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--     vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--     vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--     vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--     vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--     vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
-- end)
--
-- require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
-- require("lspconfig").biome.setup {}
--
-- -- local disableSuggestions = {
-- --     init_options = {
-- --         preferences = {
-- --             disableSuggestions = true,
-- --         }
-- --     }
-- -- }
-- -- require("lspconfig").tsserver.setup(disableSuggestions)
--
-- lsp.skip_server_setup({ 'rust_analyzer' })
--
-- -- textDocument/diagnostic support until 0.10.0 is released
-- local _timers = {}
-- local function setup_diagnostics(client, buffer)
--     if require("vim.lsp.diagnostic")._enable then
--         return
--     end
--
--     local diagnostic_handler = function()
--         local params = vim.lsp.util.make_text_document_params(buffer)
--         client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
--             if err then
--                 local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
--                 vim.lsp.log.error(err_msg)
--             end
--             if not result then
--                 return
--             end
--             vim.lsp.diagnostic.on_publish_diagnostics(
--                 nil,
--                 vim.tbl_extend("keep", params, { diagnostics = result.items }),
--                 { client_id = client.id }
--             )
--         end)
--     end
--
--     diagnostic_handler() -- to request diagnostics on buffer when first attaching
--
--     vim.api.nvim_buf_attach(buffer, false, {
--         on_lines = function()
--             if _timers[buffer] then
--                 vim.fn.timer_stop(_timers[buffer])
--             end
--             _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
--         end,
--         on_detach = function()
--             if _timers[buffer] then
--                 vim.fn.timer_stop(_timers[buffer])
--             end
--         end,
--     })
-- end
--
-- -- associate solargraph with .erb files
-- -- require("lspconfig").solargraph.setup({
-- --     filetypes = { "ruby" },
-- -- })
--
-- lsp.setup()
-- require('rust-tools').setup({})
