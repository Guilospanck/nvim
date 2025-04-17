return {
  -- TOKYO
  -- { -- You can easily change to a different colorscheme.
  --   -- Change the name of the colorscheme plugin below, and then
  --   -- change the command in the config to whatever the name of that colorscheme is.
  --   --
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     -- Load the colorscheme here.
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --     vim.cmd.colorscheme 'tokyonight-storm'
  --
  --     -- You can configure highlights by doing something like:
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },

  -- ROSE-PINE
  -- {
  --   'rose-pine/neovim',
  --   as = 'rose-pine',
  --   config = function()
  --     local function colorMyPencils(color)
  --       color = color or 'rose-pine-moon'
  --       vim.cmd.colorscheme(color)
  --       vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  --       vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  --     end
  --
  --     -- Check https://github.com/rose-pine/neovim/blob/main/lua/rose-pine.lua for more info
  --     -- and https://rosepinetheme.com/palette/ingredients/
  --     require('rose-pine').setup {
  --       disable_background = true,
  --       highlight_groups = {
  --         MiniStatuslineDevinfo = { fg = 'iris', bg = 'overlay' },
  --         MiniStatuslineFilename = { fg = 'gold', bg = 'surface' },
  --         LspReferenceRead = { bg = '#000000' },
  --         LspReferenceText = { bg = '#000000' },
  --         LspReferenceWrite = { bg = '#000000' },
  --         CursorLine = { bg = '#100E1B' },
  --       },
  --     }
  --
  --     colorMyPencils()
  --   end,
  -- },

  -- TOMORROW NIGHT
  {
    'deparr/tairiki.nvim',
    lazy = false,
    priority = 1000, -- recommended if you use tairiki as your default theme
  },
}
