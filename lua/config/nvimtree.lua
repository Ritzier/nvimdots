local M = {}

function M.setup()
    require("nvim-tree").setup({
        view = {
            width = 30,
            side = "left",
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            hide_root_folder = false,
        }
    })
end

return M
