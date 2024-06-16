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
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED
      --
      -- CMD SHIFT M
      vim.keymap.set('n', '', function()
        harpoon:list():add()
      end, { desc = 'Add to harpoon window' })

      -- WARN: currently the telescope is buggy. Without it works fine
      -- -- basic telescope configuration
      -- local conf = require('telescope.config').values
      -- local function toggle_telescope(harpoon_files)
      --   local file_paths = {}
      --   for _, item in ipairs(harpoon_files.items) do
      --     table.insert(file_paths, item.value)
      --   end
      --
      --   require('telescope.pickers')
      --     .new({}, {
      --       prompt_title = 'Harpoon',
      --       finder = require('telescope.finders').new_table {
      --         results = file_paths,
      --       },
      --       previewer = conf.file_previewer {},
      --       sorter = conf.generic_sorter {},
      --     })
      --     :find()
      -- end
      --
      -- CMD SHIFT E
      vim.keymap.set('n', '', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Open harpoon window' })

      -- Toggle previous & next buffers stored within Harpoon list
      -- CMD SHIFT P
      vim.keymap.set('n', '', function()
        harpoon:list():prev()
      end, { desc = 'Previous harpoon item' })
      -- CMD SHIFT N
      vim.keymap.set('n', '', function()
        harpoon:list():next()
      end, { desc = 'Next harpoon item' })
    end,
  },
}
