local M = {}

function M.setup()
    -- Indicate first time installation
    local packer_bootstrap = false

    -- packer.nvim configuration
    local conf = {
        profile = {
            enable = true,
            threshold = 0 -- the amount in ms that a plugins load time must be over for it to be included in the profile
        },
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
        -- Packer
        use {"wbthomason/packer.nvim"}

        -- Performance
        use {"lewis6991/impatient.nvim"}

        -- Plenary
        use {
            "nvim-lua/plenary.nvim",
            module = "plenary",
        }

        -- Colorscheme
        use {
            "EdenEast/nightfox.nvim",
            config = function()
                vim.cmd "colorscheme duskfox"
            end
        }

        -- Icons
        use {
            "kyazdani42/nvim-web-devicons",
            opt = false,
        }

        -- Bufferline
        use {
            "akinsho/bufferline.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            tag = "*",
            opt = true,
            event = "BufRead",
            config = function()
                require("config.bufferline").setup()
            end,
        }

        -- File Explorer
        use {
            "kyazdani42/nvim-tree.lua",
            opt = true,
            cmd = { "NvimTreeToggle" },
            config = function()
                require("config.nvimtree").setup()
            end
        }

        -- TreeSitter
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
            "p00f/nvim-ts-rainbow",
            opt = true,
            after = "nvim-treesitter",
            event = "BufRead",
        }
        use {
            "JoosepAlviste/nvim-ts-context-commentstring",
            opt = true,
            after = "nvim-treesitter",
        }
        use {
            "mfussenegger/nvim-ts-hint-textobject",
            opt = true,
            after = "nvim-treesitter",
        }
        use {
            "windwp/nvim-ts-autotag",
            opt = true,
            after = "nvim-treesitter",
            config = function()
                require("config.autotag")
            end
        }

        -- Startup Screen
        use {
            "goolord/alpha-nvim",
            config = function()
                require("config.alpha").setup()
            end
        }
        
        -- IndentBlankline
        use {
            "lukas-reineke/indent-blankline.nvim",
            opt = true,
            event = "BufRead",
            after = "nvim-treesitter",
            config = function()
                require("config.blankline").setup()
            end,
        }

        -- change mode colors
        use {
            "mvllow/modes.nvim",
            config = function()
                require("config.modes").setup()
            end,
        }

        -- Autopairs
        use {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup({})
            end
        }

        -- Dap
        use {
            "rcarriga/nvim-dap-ui",
            opt = false,
            config = function()
                require("config.dap_ui").setup()
            end,
            requires = {
                {
                    "mfussenegger/nvim-dap",
                    config = function()
                        require("config.dap").setup()
                    end
                },
                {
                    "Pocco81/dap-buddy.nvim",
                    opt = true,
                    cmd = { "DIInstall", "DIUninstall", "DIList" },
                    config = function()
                        require("config.dap_install")
                    end
                },
            }
        }

        -- Display colors of hex
        use {
            "norcalli/nvim-colorizer.lua",
            opt = true,
            cmd = "ColorizerToggle",
            event = "BufRead",
            config = function()
                require("colorizer").setup()
            end
        }

        -- Make =, :, ., | more tidy
        use {
            "junegunn/vim-easy-align",
            opt = true,
            cmd = "EasyAlign"
        }

        -- Comment
        use {
          "numToStr/Comment.nvim",
          keys = { "gc", "gcc", "gbc" },
          config = function()
            require("config.comment").setup()
          end,
        }

        -- Git status
        use {
            "lewis6991/gitsigns.nvim",
            event = "BufReadPre",
            wants = "plenary.nvim",
            requires = {"nvim-lua/plenary.nvim"},
            config = function()
                require("config.gitsigns").setup()
            end
        }

        -- Brow github page
        use {
            "pwntester/octo.nvim",
            cmd = "Octo",
            wants = {"telescope.nvim", "plenary.nvim", "nvim-web-devicons"},
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope.nvim",
                "kyazdani42/nvim-web-devicons"
            },
            config = function()
                require("octo").setup()
            end,
            disable = false
        }

        -- Which key
        use {
            "folke/which-key.nvim",
            event = "VimEnter",
            config = function()
                require("config.whichkey").setup()
            end
        }

        -- Motions
        use {"andymass/vim-matchup", event="CursorMoved"}
        use {"wellle/targets.vim", event="CursorMoved"}
        use {"unblevable/quick-scope", event="CursorMoved", disable=false}
        use {"chaoren/vim-wordmotion", opt=true, fn={"<Plug>WordMotion_w"}}

        use {
            "kazhala/close-buffers.nvim",
            cmd = {"BDelete", "BWipeout"}
        }

        use {
            "matbme/JABS.nvim",
            cmd = "JABSOpen",
            config = function()
                require("config.jabs").setup()
            end,
            disable = false,
        }

        use {
            "antoinemadec/FixCursorHold.nvim",
            event = "BufReadPre",
            config = function()
                vim.g.cursorhold_updatetime = 100
            end
        }

        use { "google/vim-searchindex", event = "BufReadPre" }
        use { "tyru/open-browser.vim", event = "BufReadPre" }

        -- Change and make notification better
        use {
            "rcarriga/nvim-notify",
            event = "BufReadPre",
            opt = false,
            config = function()
                require("config.nvim_notify").setup()
            end
        }

        -- Go
        use {
            "fatih/vim-go",
            opt = true,
            ft = "go",
            run = ":GoInstallBinaries",
            config = function()
                require("config.lang_go").setup()
            end
        }

        -- Rust
        use {
            "rust-lang/rust.vim",
            opt = true,
            ft = "rust"
        }
        use {
           "simrat39/rust-tools.nvim",
            opt = true,
            ft = "rust",
            config = function()
                require("config.rust_tools").setup()
            end,
            requires = {{"nvim-lua/plenary.nvim", opt=false}}
        }

        -- ?
        use {
            "sindrets/diffview.nvim",
            opt = true,
            requires = 'nvim-lua/plenary.nvim',
            cmd = {"DiffviewOpen"},
        }

        -- Markdown
        use {
            "iamcco/markdown-preview.nvim",
            opt = true,
            ft = "markdown",
            run = "cd app && yarn install",
        }

        -- CSV
        use {
            "chrisbra/csv.vim",
            opt = true,
            ft = "csv",
        }

        -- Better surround
        use {
            "tpope/vim-surround",
            event = "BufReadPre",
        }
        use {
            "Matt-A-Bennett/vim-surround-funk",
            event = "BufReadPre",
            config = function()
                require("config.surroundfunk").setup()
            end,
            disable = true
        }

        -- Wilder
        use {
            "gelguy/wilder.nvim",
            event = "CmdlineEnter",
            config = function()
                require("config.wilder")
            end,
            requires = { { "romgrk/fzy-lua-native", after = "wilder.nvim" } }
        }

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            opt = true,
            module = "telescope",
            cmd = "Telescope",
            config = function()
                require("config.telescope")
            end
        }

        -- Sniprun



        -- Bootstrap Neovim
        if packer_bootstrap then
            print "Restart Neovim required after installation!"
            require("packer").sync()
        end
    end

    -- Init and start packer
    packer_init()
    local packer = require "packer"

    -- Performance
    pcall(require, "impatient")
    -- pcall(require, "packer_compiled")

    packer.init(conf)
    packer.startup(plugins)
end

return M
