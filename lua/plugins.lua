local M = {}

function M.setup()
  local packer_bootstrap = false

  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  local function plugins(use)
    -- Packer can manage itself !
    use 'wbthomason/packer.nvim'

    -- Base config

    -- Doc
    use { "nanotee/luv-vimdocs", event = "BufReadPre" }
    use { "milisims/nvim-luaref", event = "BufReadPre" }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require("config.whichkey").setup()
      end,
    }

    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufReadPre",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
        { "windwp/nvim-ts-autotag", event = "InsertEnter" },
        { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
        { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
        { "RRethy/nvim-treesitter-textsubjects", event = "BufReadPre" },
        { "nvim-treesitter/playground", cmd = { "TSPlaygroundToggle" } },
        {
          "lewis6991/spellsitter.nvim",
          config = function()
            require("spellsitter").setup()
          end,
        },
        { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre", disable = true },
        -- { "yioneko/nvim-yati", event = "BufReadPre" },
      },
    }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Better Comment
    use {
      "numToStr/Comment.nvim",
      opt = true,
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("Comment").setup {}
      end,
    }

    -- Code documentation plugins

    -- Function to generate documentation for classes and functions in many many
    -- languages
    use {
      "danymat/neogen",
      config = function()
        require("config.neogen").setup()
      end,
      cmd = { "Neogen" },
      module = "neogen",
      disable = false,
    }

    use {
      "kkoomen/vim-doge",
      run = ":call doge#install()",
      config = function()
        require("config.doge").setup()
      end,
      cmd = { "DogeGenerate", "DogeCreateDocStandard" },
      disable = false,
    }


    -- Easy hopping
    use {
      "phaazon/hop.nvim",
      cmd = { "HopWord", "HopChar1" },
      config = function()
        require("hop").setup {}
      end,
    }

    -- Easy motion
    use {
      "ggandor/lightspeed.nvim",
      keys = { "s", "S", "f", "F", "t", "T" },
      config = function()
        require("lightspeed").setup {}
      end,
    }

    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
    }

    -- Status line
    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = function()
       require("config.lualine").setup()
      end,
      requires = { "nvim-web-devicons" },
    }

    -- File browser
    use {
     "kyazdani42/nvim-tree.lua",
     requires = {
       "kyazdani42/nvim-web-devicons",
     },
     cmd = { "NvimTreeToggle", "NvimTreeClose" },
       config = function()
         require("config.nvimtree").setup()
       end,
    }

    -- Fuzzy finder
    use {
     "ibhagwan/fzf-lua",
      requires = { "kyazdani42/nvim-web-devicons" },
    }

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      wants = {
        "nvim-lsp-installer",
        "lsp_signature.nvim",
        "coq_nvim",
        -- "mason.nvim",
        -- "mason-lspconfig.nvim",
        -- "mason-tool-installer.nvim",
        "lua-dev.nvim",
        "vim-illuminate",
        "schemastore.nvim",
        "typescript.nvim",
        "nvim-navic",
      },
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "williamboman/nvim-lsp-installer",
        -- "williamboman/mason.nvim",
        -- "williamboman/mason-lspconfig.nvim",
        "RRethy/vim-illuminate",
        -- "WhoIsSethDaniel/mason-tool-installer.nvim",
        "b0o/schemastore.nvim",
        "folke/lua-dev.nvim",
        "ray-x/lsp_signature.nvim",
        "jose-elias-alvarez/typescript.nvim",

        {
          -- "SmiteshP/nvim-navic",
          "alpha2phi/nvim-navic",
          config = function()
            require("nvim-navic").setup {}
          end,
          module = { "nvim-navic" },
        },
      },
    }

    use {
      'ms-jpq/coq_nvim',
      branch = 'coq',
      event = "InsertEnter",
      opt = true,
      run = ":COQdeps",
      config = function()
        require("config.coq").setup()
      end,
      requires = {
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        { "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
      },
    }

    -- Git
    use {
      'TimUntersberger/neogit',
      requires = 'nvim-lua/plenary.nvim',
      cmd = "Neogit",
      config = function()
        require("config.neogit").setup()
      end,
    }
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.gitsigns").setup()
      end,
    }
    use {
      "tpope/vim-fugitive",
      opt = true,
      cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
      requires = {
        "tpope/vim-rhubarb",
        "idanarye/vim-merginal",
        --[[ "rhysd/committia.vim", ]]
      },
      -- wants = { "vim-rhubarb" },
    }
    use { "rbong/vim-flog", cmd = { "Flog", "Flogsplit", "Floggit" }, wants = { "vim-fugitive" } }
    use {
      "ruifm/gitlinker.nvim",
      requires = "nvim-lua/plenary.nvim",
      module = "gitlinker",
      config = function()
        require("gitlinker").setup { mappings = nil }
      end,
    }
    use {
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
    }
    use { "f-person/git-blame.nvim", cmd = { "GitBlameToggle" } }
        use {
      "tanvirtin/vgit.nvim",
      config = function()
        require("vgit").setup()
      end,
      cmd = { "VGit" },
    }
    use { "knsh14/vim-github-link", cmd = { "GetCommitLink", "GetCurrentBranchLink", "GetCurrentCommitLink" } }
    use { "segeljakt/vim-silicon", cmd = { "Silicon" } }
    use { "mattn/vim-gist", opt = true, requires = { "mattn/webapi-vim" }, cmd = { "Gist" } }



    -- Old stylish plugings, maybe to be replaced with nicer, faster more recent
    -- lua ones
    -- use 'scrooloose/nerdtree'
    -- use 'tpope/vim-fugitive'
    -- use 'Xuyuanp/nerdtree-git-plugin'
    use 'majutsushi/tagbar'

    -- { 'neoclide/coc.nvim', 'branch': 'release' }
    use 'puremourning/vimspector'

    -- Colorschemes and themes
    use 'arcticicestudio/nord-vim'
    use 'altercation/vim-colors-solarized'

    -- Apparently cool but I should dive deeper into them at some point
    use 'SirVer/ultisnips'

    -- Show off plug ins (that also help coding actually)
    use 'airblade/vim-gitgutter'

    -- Language plugins
    use 'lervag/vimtex'
    use 'hashivim/vim-terraform'
    use 'fatih/vim-go'
    use 'cespare/vim-toml'
    use 'rust-lang/rust.vim'
    -- use 'OmniSharp/omnisharp-vim'
    use 'towolf/vim-helm'
    -- use 'Shadowsith/vim-dotnet'
    use 'kongo2002/fsharp-vim'
    use 'ianks/vim-tsx'
    use 'leafgarland/typescript-vim'
    use 'lifepillar/pgsql.vim'
    use 'chr4/nginx.vim'

    -- Cool tools for noobs I should get rid of at some point
    -- use 'terryma/vim-multiple-cursors'
    use 'editorconfig/editorconfig-vim'
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
