local M = {}

function M.setup()
    -- Indicate first time installation
    local packer_bootstrap = false

    -- packer.nvim configuration
    local conf = {
        display = {
            open_fn = function()
                return require("packer.util").float {border = "rounded"}
            end
        }
    }

    -- Check if packer.nvim is installed
    -- Run PackerCompile if there are changes in this file
    local function packer_init()
        local fn = vim.fn
        local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
        if fn.empty(fn.glob(install_path)) > 0 then
            packer_bootstrap =
                fn.system {
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/wbthomason/packer.nvim",
                install_path
            }
            vim.cmd [[packadd packer.nvim]]
        end
        vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    end

    -- Plugins
    local function plugins(use)
        use {"wbthomason/packer.nvim"}

        use {
            "jiangmiao/auto-pairs"
        }

        -- Colorscheme
        use {
            "EdenEast/nightfox.nvim",
            config = function()
                vim.cmd "colorscheme duskfox"
            end
        }

        use {"nathom/filetype.nvim"}

        use {"lewis6991/impatient.nvim"}

        --Treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
            opt = true,
            run = ":TSUpdate",
            event = "BufRead",
            config = function()
                require("config.treesitter").setup()
            end,
        }

        use {
            "nvim-treesitter/nvim-treesitter-textobjects",
            opt = true,
            after = "nvim-treesitter",
        }

        use {
            "mfussenegger/nvim-ts-hint-textobject",
            opt = true,
            after = "nvim-treesitter",
        }

        use {
            "p00f/nvim-ts-rainbow",
            opt = true,
            after = "nvim-treesitter",
            event = "BufRead"
        }

        use {
            "JoosepAlviste/nvim-ts-context-commentstring",
            opt = true,
            after = "nvim-treesitter"
        }

        use {
            "windwp/nvim-ts-autotag",
            opt = true,
            after = "nvim-treesitter",
            config = function()
                require("config.autotag")
            end
        }

        use {
            "andymass/vim-matchup",
            opt = true,
            after = "nvim-treesitter",
            config = function()
                require("config.matchup")
            end
        }

        -- IndentBlankline
        use {
            "lukas-reineke/indent-blankline.nvim",
            after = "nvim-treesitter",
            event = "BufReadPre",
            config = function()
                require("config.indent_blankline").setup()
            end
        }

        -- User interface

        use {
            "kyazdani42/nvim-web-devicons",
            module = "nvim-web-devicons",
            config = function()
                require('nvim-web-devicons').setup {default = true}
            end
        }

        use {
            "stevearc/dressing.nvim",
            event = "BufReadPre",
            config = function()
                require("dressing").setup {
                    input = { relative = "editor" },
                    select = {
                        backend = { "telescope", "fzf", "builtin" },
                    }
                }
            end,
            disable = false
        }

        use {"nvim-telescope/telescope.nvim", module = "telescope", as = "telescope"}

        use {
            "akinsho/nvim-bufferline.lua",
            event = "BufReadPre",
            config = function()
                require("config.bufferline").setup()
            end
        }

         use {
            "kyazdani42/nvim-tree.lua",
            opt = true,
            wants = "nvim-web-devicons",
            cmd = { "NvimTreeToggle", "NvimTreeClose" },
            module = "nvim-tree",
            config = function()
                require("config.nvimtree").setup()
            end,
        }


        if packer_bootstrap then
            print "Restart Neovim required after installation!"
            require("packer").sync()
        end
    end

    packer_init()

    local packer = require "packer"
    packer.init(conf)
    packer.startup(plugins)
end

return M
