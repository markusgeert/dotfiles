return {
    "tpope/vim-fugitive",

    config = function()
        vim.keymap.set("n", "<leader>gs", "<cmd>vert Git<CR>");
    end
}
