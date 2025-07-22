-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

vim.cmd [[let &shell = '"C:/Users/KMO8LOD/AppData/Local/Programs/Git/bin/bash.exe"']]
vim.cmd [[let &shellcmdflag = '-s']]
require("lazy").setup({
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
{ 'kepano/flexoki-neovim', name = 'flexoki' },
    -- Telescope
    'nvim-telescope/telescope.nvim',
    -- nvim-autopairs
    {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
},
{'ThePrimeagen/vim-be-good'},
    -- flash.nvim
    {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
  modes = {
      char = {
        enabled = true,
        -- domyślnie ignoruje niektóre filetype’y:
        -- filetypes_denylist = { "NvimTree", ... }
        -- możemy to nadpisać
        filetypes_denylist = {}, -- <- pozwól wszędzie, nawet w NvimTree
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
},
    -- clang-format
    {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cpp = { "clang_format" },
        c = { "clang_format" },
        h = { "clang_format" },

        -- dodaj inne rozszerzenia, jeśli chcesz
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
    },
  },

    -- vscode theme
{
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup({
        style = "dark",        -- lub "light", zależnie od preferencji
        transparent = false,   -- czy tło ma być przezroczyste
      })
      vim.cmd("colorscheme flexoki")
    end,
  },

  -- Pluginy
  "nvim-lua/plenary.nvim",

  -- LSP
  "neovim/nvim-lspconfig",

    -- Autouzupełnianie
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",

  -- Drzewko plików
 {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- opcjonalne ikonki
  config = function()
  require("nvim-tree").setup({
    renderer = {
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
  })
  end
},
 -- terminal
{
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-\\>]],
      shell = "C:/Users/KMO8LOD/AppData/Local/Programs/Git/bin/bash.exe",
      direction = "horizontal", -- inne opcje: 'floating', 'vertical'
    })
  end,
},
-- bufferline
{
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers", -- lub "tabs" jeśli chcesz taby zamiast buforów
          diagnostics = "nvim_lsp",
          separator_style = "slant", -- opcjonalnie: "thin", "slant", "padded_slant"
          show_buffer_close_icons = false,
          show_close_icon = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left"
            }
          }
        }
      })
    end
  },


  -- Kolorowanie składni
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

  -- Linia statusu
  "nvim-lualine/lualine.nvim",
  "mfussenegger/nvim-dap",
})

-- treesitter
require("nvim-treesitter.configs").setup {
  ensure_installed = { "cpp", "c", "lua" },
  highlight = { enable = true },
}

-- lsp
local lspconfig = require("lspconfig")
lspconfig.clangd.setup {}
-- cmp
local cmp = require("cmp")
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }
}
vim.g.mapleader = " "

-- statusline
require("lualine").setup()

-- ToggleTerm
vim.keymap.set("n", "<C-_>", ":ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-_>", [[<C-\><C-n>:ToggleTerm<CR>]], { noremap = true, silent = true })


-- nvim-tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.termguicolors = true
vim.o.mouse = "a"

-- saving file
-- Map Ctrl+S to save in all modes
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<C-s>', ':w<CR>', opts)  -- normal mode
map('i', '<C-s>', '<Esc>:w<CR>', opts)  -- insert mode
map('v', '<C-s>', '<Esc>:w<CR>gv', opts)  -- visual mode
map('x', '<C-s>', '<Esc>:w<CR>gv', opts)  -- visual block mode
map('s', '<C-s>', '<Esc>:w<CR>i', opts)  -- select mode

vim.o.updatetime = 550
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.opt.clipboard = "unnamedplus"

vim.lsp.enable('pyright')
-- bufferline
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", {})
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", {})
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", {})
