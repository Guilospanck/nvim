-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Harpoon lets you fly through previous marked items.
  -- From https://github.com/ThePrimeagen/harpoon/tree/harpoon2
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()
      local list = harpoon:list()

      -- CMD SHIFT M
      vim.keymap.set('n', '', function()
        local abs_path = vim.fn.expand '%:p'
        list:add { value = abs_path }
      end, { desc = 'Add to harpoon window' })

      -- CMD SHIFT E
      vim.keymap.set('n', '', function()
        harpoon.ui:toggle_quick_menu(list)
      end, { desc = 'Open harpoon window' })

      -- Toggle previous & next buffers stored within Harpoon list
      -- CMD SHIFT P
      vim.keymap.set('n', '', function()
        list:prev()
      end, { desc = 'Previous harpoon item' })
      -- CMD SHIFT N
      vim.keymap.set('n', '', function()
        list:next()
      end, { desc = 'Next harpoon item' })
    end,
  },
  -- Theme for neovim
  {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      local function colorMyPencils(color)
        color = color or 'rose-pine-moon'
        vim.cmd.colorscheme(color)
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      end

      -- Check https://github.com/rose-pine/neovim/blob/main/lua/rose-pine.lua for more info
      -- and https://rosepinetheme.com/palette/ingredients/
      require('rose-pine').setup {
        disable_background = true,
        highlight_groups = {
          MiniStatuslineDevinfo = { fg = 'iris', bg = 'overlay' },
          MiniStatuslineFilename = { fg = 'gold', bg = 'surface' },
          LspReferenceRead = { bg = 'highlight_high' },
          LspReferenceText = { bg = 'highlight_high' },
          LspReferenceWrite = { bg = 'highlight_high' },
          CursorLine = { bg = '#100E1B' },
        },
      }

      colorMyPencils()
    end,
  },
  -- To come back to a previous change in an easier way
  {
    'mbbill/undotree',
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_DiffpanelHeight = 20
      vim.g.undotree_SplitWidth = 30
      vim.g.undotree_WindowLayout = 2
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
  },
}
