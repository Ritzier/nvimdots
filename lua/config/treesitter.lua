local M = {}

function M.setup()
    --vim.api.nvim_command("set foldmethod=expr")
    --vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")

    require("nvim-treesitter.configs").setup {
        ensure_installed = "all",

        sync_install = false,

        highlight = {
            enable = true,
        },

        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil,
        },

        indent = {
            enable = true,
        },
        context_commentstring = { enable = true, enable_autocmd = false },
        matchup = { enable = true },
    }

    require("nvim-treesitter.install").prefer_git = true

	local parsers = require("nvim-treesitter.parsers").get_parser_configs()
	for _, p in pairs(parsers) do
		p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
	end
end

return M
