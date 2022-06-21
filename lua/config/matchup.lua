local M = {}

function M.setup()
    vim.cmd([[let g:matchup_matchparen_offscreen = {'method': 'popup'}]])
end

return M
