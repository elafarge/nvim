local M = {}

function M.setup()
  require('lazy').setup({
    -- Base config

    -- Doc
    { "nanotee/luv-vimdocs",  event = "BufReadPre" },
    { "milisims/nvim-luaref", event = "BufReadPre" },

    -- WhichKey
    {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require("config.whichkey").setup()
      end,
    },

    { "nvim-lua/plenary.nvim", module = "plenary" },

    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
    },
    -- {
    --   "nvim-treesitter/nvim-treesitter",
    --   opt = true,
    --   event = "BufReadPre",
    --   build = ":TSUpdate",
    --   config = function()
    --     require("config.treesitter").setup()
    --   end,
    --   dependencies = {
    --     { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
    --     { "windwp/nvim-ts-autotag", event = "InsertEnter" },
    --     { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
    --     { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
    --     { "RRethy/nvim-treesitter-textsubjects", event = "BufReadPre" },
    --     { "nvim-treesitter/playground", cmd = { "TSPlaygroundToggle" } },
    --     {
    --       "lewis6991/spellsitter.nvim",
    --       config = function()
    --         require("spellsitter").setup()
    --       end,
    --     },
    --     { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre", disable = true },
    --     -- { "yioneko/nvim-yati", event = "BufReadPre" },
    --   },
    -- },

    -- Better icons
    {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    },

    -- Better Comment
    {
      "numToStr/Comment.nvim",
      opt = true,
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("Comment").setup {}
      end,
    },

    -- Code documentation plugins

    -- Function to generate documentation for classes and functions in many many
    -- languages
    {
      "danymat/neogen",
      config = function()
        require("config.neogen").setup()
      end,
      cmd = { "Neogen" },
      module = "neogen",
      disable = false,
    },

    {
      "kkoomen/vim-doge",
      build = ":call doge#install()",
      config = function()
        require("config.doge").setup()
      end,
      cmd = { "DogeGenerate", "DogeCreateDocStandard" },
      disable = false,
    },


    -- Easy hopping
    {
      "phaazon/hop.nvim",
      cmd = { "HopWord", "HopChar1" },
      config = function()
        require("hop").setup {}
      end,
    },

    -- Easy motion
    -- {
    --   "ggandor/lightspeed.nvim",
    --   keys = { "s", "S", "f", "F", "t", "T" },
    --   config = function()
    --     require("lightspeed").setup {}
    --   end,
    -- },

    -- Markdown
    {
      "iamcco/markdown-preview.nvim",
      build = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
    },

    {
      "SmiteshP/nvim-navic",
      dependencies = "neovim/nvim-lspconfig",
      config = function()
        require("nvim-navic").setup()
      end,
    },

    -- Status line
    {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = function()
        require("config.lualine").setup()
      end,
      dependencies = { "nvim-web-devicons", "nvim-navic" },
    },

    -- File browser
    {
      "kyazdani42/nvim-tree.lua",
      dependencies = {
        "kyazdani42/nvim-web-devicons",
      },
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require("config.nvimtree").setup()
      end,
    },

    -- Fuzzy finders
    {
      "ibhagwan/fzf-lua",
      dependencies = { "kyazdani42/nvim-web-devicons" },
    },

    {
      "nvim-telescope/telescope.nvim",
      opt = true,
      config = function()
        require("config.telescope").setup()
      end,
      cmd = { "Telescope" },
      module = "telescope",
      keys = {
        "<leader>f",
        "<leader>p",
        {
          "<leader>zc",
          function() require("telescope.builtin").colorscheme({ enable_preview = true }) end,
          desc = "Colorscheme",
        },
      },
      wants = {
        "plenary.nvim",
        "popup.nvim",
        "telescope-fzf-native.nvim",
        "telescope-project.nvim",
        "telescope-repo.nvim",
        "telescope-file-browser.nvim",
        "project.nvim",
      },
      dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-project.nvim",
        "cljoly/telescope-repo.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        {
          "ahmedkhalf/project.nvim",
          config = function()
            require("project_nvim").setup {}
          end,
        },
      },
    },

    -- LSP
    {
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      wants = {
        -- "nvim-lsp-installer",
        "lsp_signature.nvim",
        "nvim-cmp",
        "neodev.nvim",
        "mason.nvim",
        "mason-lspconfig.nvim",
        "mason-tool-installer.nvim",
        "vim-illuminate",
        "null-ls.nvim",
        "schemastore.nvim",
        "typescript.nvim",
        "nvim-navic",
      },
      config = function()
        require("config.lsp").setup()
      end,
      dependencies = {
        -- "williamboman/nvim-lsp-installer",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "RRethy/vim-illuminate",
        "jose-elias-alvarez/null-ls.nvim",
        "folke/neodev.nvim",
        "b0o/schemastore.nvim",
        "ray-x/lsp_signature.nvim",
        "jose-elias-alvarez/typescript.nvim",
        "SmiteshP/nvim-navic",
      },
    },

    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      wants = { "LuaSnip" },
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        {
          "L3MON4D3/LuaSnip",
          wants = "friendly-snippets",
          config = function()
            require("config.luasnip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
      },
      disable = false,
    },

    {
      "folke/trouble.nvim",
      event = "BufReadPre",
      wants = "nvim-web-devicons",
      cmd = { "TroubleToggle", "Trouble" },
      config = function()
        require("trouble").setup {
          use_diagnostic_signs = true,
        }
      end,
    },

    {
      "tami5/lspsaga.nvim",
      event = "VimEnter",
      cmd = { "Lspsaga" },
      config = function()
        require("lspsaga").setup {}
      end,
    },

    -- AI assisted coding
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          suggestion = { enabled = true },
          panel = { enabled = true, auto_refresh = true },
          filetypes = {
            yaml = true,
          }
        })
      end,
    },

    {
      "zbirenbaum/copilot-cmp",
      config = function()
        require("copilot_cmp").setup()
      end
    },

    -- Git
    {
      'TimUntersberger/neogit',
      dependencies = 'nvim-lua/plenary.nvim',
      cmd = "Neogit",
      config = function()
        require("config.neogit").setup()
      end,
    },
    {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      wants = "plenary.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.gitsigns").setup()
      end,
    },
    { "rbong/vim-flog",        cmd = { "Flog", "Flogsplit", "Floggit" }, wants = { "vim-fugitive" } },
    {
      "ruifm/gitlinker.nvim",
      dependencies = "nvim-lua/plenary.nvim",
      module = "gitlinker",
      config = function()
        require("gitlinker").setup { mappings = nil }
      end,
    },
    {
      "akinsho/git-conflict.nvim",
      cmd = {
        "GitConflictChooseTheirs",
        "GitConflictChooseOurs",
        "GitConflictChooseBoth",
        "GitConflictChooseNone",
        "GitConflictNextConflict",
        "GitConflictPrevConflict",
        "GitConflictListQf",
      },
      config = function()
        require("git-conflict").setup()
      end,
    },
    {
      "tanvirtin/vgit.nvim",
      config = function()
        require("vgit").setup()
      end,
      cmd = { "VGit" },
    },
    { "knsh14/vim-github-link", cmd = { "GetCommitLink", "GetCurrentBranchLink", "GetCurrentCommitLink" } },
    { "segeljakt/vim-silicon",  cmd = { "Silicon" } },
    {
      "mattn/vim-gist",
      opt = true,
      dependencies = {
        "mattn/webapi-vim" },
      cmd = {
        "Gist" }
    },

    -- Syntax plugins
    'towolf/vim-helm',

    -- Old stylish plugings, maybe to be replaced with nicer, faster more recent
    -- lua ones
    'tpope/vim-fugitive',
    'majutsushi/tagbar',

    -- Colorschemes and themes
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    'arcticicestudio/nord-vim',
    -- 'altercation/vim-colors-solarized',

    -- Cool tools for noobs I should get rid of at some point
    'editorconfig/editorconfig-vim',
  })
end

return M
