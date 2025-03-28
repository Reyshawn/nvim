return {
  -- { "alexmozaidze/palenight.nvim", lazy = false },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme("tokyonight-storm")
      -- Make background transparent
      vim.api.nvim_set_hl(0, "Normal",     { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC",   { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }) -- optional: for floating windows
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" }) -- optional: cleaner float borders
    end
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        fast_wrap = {
          map = '<C-e>',
          chars = { '{', '[', '(', '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = '$',
          keys = '123456789qwertyuiop',
          check_comma = true,
          highlight = 'Search',
          highlight_grey = 'Comment'
        }
      })
    end
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "swift",
          "typescript",
          "tsx",
          "javascript",
          "json",
          "lua",
          "vim",
          "bash",
          "markdown"
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
      require("neo-tree").setup({
        -- your other settings can go here
        window = {
          width = 30,
          mappings = {
            ["<space>"] = false,
            ["<Right>"] = "toggle_node",
            ["<Right>"] = "open",
            ["<Left>"] = "toggle_node",
          }
        }
      })
  
      -- 💡 Transparent background for neo-tree
      local groups = {
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeEndOfBuffer",
        "NeoTreeWinSeparator",
        "NeoTreeStatusLine",
        "NeoTreeStatusLineNC",
      }
  
      for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
      end
      vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#3e4251", bg = "none" })
      vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#0da0e8" })
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'auto',
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          icons_enabled = true,
          globalstatus = true, -- makes it look more like VSCode's bottom bar
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
      }
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- Required
      "nvim-telescope/telescope-fzf-native.nvim",  -- Optional, faster sorting
      build = "make",  -- Needed for fzf-native
    },
    cmd = "Telescope",  -- Load on command
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help Tags" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = {
            prompt_position = "top",
          },
          sorting_strategy = "ascending",
          winblend = 10,
          file_ignore_patterns = { "node_modules" }
        },
        pickers = {
          find_files = {
            hidden = true
          }
        }
      })
  
      -- Optional: load fzf sorter if installed
      pcall(require("telescope").load_extension, "fzf")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#a6cb72", bg = "none" })
      vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffdb4f", bg = "none" })
      vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#dd5e56", bg = "none" })
    end
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  }
}