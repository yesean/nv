local plugins = {

   ["nvim-lua/plenary.nvim"] = {},
   ["lewis6991/impatient.nvim"] = {},
   ["wbthomason/packer.nvim"] = {},
   ["NvChad/extensions"] = {},

   ["NvChad/base46"] = {
      after = "plenary.nvim",
      config = function()
         local ok, base46 = pcall(require, "base46")

         if ok then
            base46.load_theme()
         end
      end,
   },

   ["NvChad/nvterm"] = {
      module = "nvterm",
      config = function()
         require "plugins.configs.nvterm"
      end,
   },

   ["kyazdani42/nvim-web-devicons"] = {
      after = "base46",
      config = function()
         require "plugins.configs.icons"
      end,
   },

   ["SmiteshP/nvim-gps"] = {
      event = "CursorMoved",
      config = function()
         require "plugins.configs.gps"
      end,
   },

   ["akinsho/bufferline.nvim"] = {
      after = "nvim-web-devicons",
      config = function()
         require "plugins.configs.bufferline"
      end,
   },

   ["lukas-reineke/indent-blankline.nvim"] = {
      event = "BufRead",
      config = function()
         require("plugins.configs.others").blankline()
      end,
   },

   ["NvChad/nvim-colorizer.lua"] = {
      event = "BufRead",
      config = function()
         require("plugins.configs.others").colorizer()
      end,
   },

   ["nvim-treesitter/nvim-treesitter"] = {
      event = { "BufRead", "BufNewFile" },
      run = ":TSUpdate",
      config = function()
         require "plugins.configs.treesitter"
      end,
   },

   -- git stuff
   ["lewis6991/gitsigns.nvim"] = {
      opt = true,
      config = function()
         require("plugins.configs.others").gitsigns()
      end,
      setup = function()
         require("core.utils").packer_lazy_load "gitsigns.nvim"
      end,
   },

   -- lsp stuff

   ["yesean/nvim-lsp-installer"] = {
      opt = true,
      setup = function()
         require("core.utils").packer_lazy_load "nvim-lsp-installer"
         -- reload the current file so lsp actually starts for it
         vim.defer_fn(function()
            vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
         end, 0)
      end,
   },

   ["neovim/nvim-lspconfig"] = {
      after = "nvim-lsp-installer",
      module = "lspconfig",
      config = function()
         require "plugins.configs.lsp_installer"
         require "plugins.configs.lspconfig"
      end,
   },

   ["jose-elias-alvarez/null-ls.nvim"] = {
      config = function()
         require "plugins.configs.null-ls"
      end,
   },

   -- load luasnips + cmp related in insert mode only

   ["hrsh7th/nvim-cmp"] = {
      event = { "InsertEnter", "CmdlineEnter" },
      config = function()
         require "plugins.configs.cmp"
      end,
   },

   ["rafamadriz/friendly-snippets"] = {
      module = "cmp_nvim_lsp",
      after = "nvim-cmp",
   },

   ["L3MON4D3/LuaSnip"] = {
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         require("plugins.configs.others").luasnip()
      end,
   },

   ["saadparwaiz1/cmp_luasnip"] = {
      after = "nvim-cmp",
   },

   ["hrsh7th/cmp-nvim-lua"] = {
      after = "nvim-cmp",
   },

   ["hrsh7th/cmp-nvim-lsp"] = {
      after = "nvim-cmp",
   },

   ["hrsh7th/cmp-buffer"] = {
      after = "nvim-cmp",
   },

   ["hrsh7th/cmp-path"] = {
      after = "nvim-cmp",
   },

   ["hrsh7th/cmp-nvim-lsp-signature-help"] = {
      after = "nvim-cmp",
   },

   ["hrsh7th/cmp-cmdline"] = {
      after = "nvim-cmp",
   },

   ["dmitmel/cmp-cmdline-history"] = {
      after = "nvim-cmp",
   },

   -- misc plugins
   ["windwp/nvim-autopairs"] = {
      after = "nvim-cmp",
      config = function()
         require("plugins.configs.others").autopairs()
      end,
   },

   ["goolord/alpha-nvim"] = {
      disable = true,
      config = function()
         require "plugins.configs.alpha"
      end,
   },

   ["numToStr/Comment.nvim"] = {
      module = "Comment",
      keys = { "gc", "gb" },
      config = function()
         require("plugins.configs.others").comment()
      end,
   },

   -- file managing , picker etc
   ["kyazdani42/nvim-tree.lua"] = {
      ft = "alpha",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = function()
         require "plugins.configs.nvimtree"
      end,
   },

   ["nvim-telescope/telescope.nvim"] = {
      cmd = "Telescope",
      config = function()
         require "plugins.configs.telescope"
      end,
   },

   ["folke/which-key.nvim"] = {
      opt = true,
      setup = function()
         require("core.utils").packer_lazy_load "which-key.nvim"
      end,
      config = function()
         require "plugins.configs.whichkey"
      end,
   },
}

require("core.packer").run(plugins)
