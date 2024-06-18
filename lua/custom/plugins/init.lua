-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Used to toggle a terminal so its easier to run applications in the background:
  -- https://github.com/akinsho/toggleterm.nvim
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      direction = 'horizontal',
      open_mapping = [[<c-\>]],
    },
  },
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
}
