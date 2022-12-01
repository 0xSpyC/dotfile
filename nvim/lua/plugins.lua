local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
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

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

	use { 
		"Shatur/neovim-ayu",
      config = function()
		  require('ayu').setup({
				mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
				overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
			})
      end,
    }
    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

	-- Lualine
	use {
		'nvim-lualine/lualine.nvim',
		config = function()
			require("config.lualine").setup()
		end,
		require = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	-- Git
	use {
		"TimUntersberger/neogit",
		cmd = "Neogit",
		config = function()
			require("config.neogit").setup()
		end,
	}

	-- WhichKey
	use {
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("config.whichkey").setup()
		end,
	}

	-- IndentLine
	use {
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = function()
			require("config.indentblankline").setup()
		end,
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

	-- LspConfig
	use {
		'neovim/nvim-lspconfig',
		config = function()
			require("config.lspconfig").setup()
		end,
	}
	
	use 'hrsh7th/cmp-nvim-lsp'

	use 'hrsh7th/cmp-buffer'

	use 'onsails/lspkind-nvim'

	use {
		'hrsh7th/nvim-cmp',
		config = function()
			require("config.cmp").setup()
		end,
	}
	
	use {
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require("config.treesitter").setup()
		end,
	}

	use {
		'windwp/nvim-ts-autotag',
		config = function()
			require("config.autotag").setup()
		end,
	}

	use {
		'windwp/nvim-autopairs',
		config = function()
			require("config.autopairs").setup()
		end,
	}
		

	use '42Paris/42header'

	use {
		'nvim-telescope/telescope.nvim',
		config = function()
			require("config.telescope").setup()
		end,
	}

	use {
		'akinsho/nvim-bufferline.lua',
		config = function()
			require("config.bufferline").setup()
		end,
	}

	use {
		'jose-elias-alvarez/null-ls.nvim',
		config = function()
			require("config.null-ls").setup()
		end,
	}

	use 'nvim-telescope/telescope-file-browser.nvim'

	use {
			'williamboman/mason.nvim',
			config = function()
			require("mason").setup()
			end,
	}

	use {
			'williamboman/mason-lspconfig.nvim',
			config = function()
			require("mason-lspconfig").setup()
			end,
	}

	use 'L3MON4D3/LuaSnip'
	
	-- Bootstrap Neovim
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
