-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
local base = {
  -- Harpoon lets you fly through previous marked items.
  -- From https://github.com/ThePrimeagen/harpoon/tree/harpoon2
  -- {
  --   'ThePrimeagen/harpoon',
  --   branch = 'harpoon2',
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   config = function()
  --     local harpoon = require 'harpoon'
  --     harpoon:setup()
  --     local list = harpoon:list()

  --     -- CMD SHIFT M
  --     vim.keymap.set('n', '', function()
  --       local abs_path = vim.fn.expand '%:p'
  --       list:add { value = abs_path }
  --     end, { desc = 'Add to harpoon window' })

  --     -- CMD SHIFT E
  --     vim.keymap.set('n', '', function()
  --       harpoon.ui:toggle_quick_menu(list)
  --     end, { desc = 'Open harpoon window' })

  --     -- Toggle previous & next buffers stored within Harpoon list
  --     -- CMD SHIFT P
  --     vim.keymap.set('n', '', function()
  --       list:prev()
  --     end, { desc = 'Previous harpoon item' })
  --     -- CMD SHIFT N
  --     vim.keymap.set('n', '', function()
  --       list:next()
  --     end, { desc = 'Next harpoon item' })
  --   end,
  -- },
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
  -- Allows, amongst other things, change from cases:
  -- crs: coerce to snake case
  -- crm coerce to mixed case
  -- crc coerce to camel case
  -- cru coerce to uppercase
  -- cr- coerce to dash-case
  -- cr. coerce to dot.case
  {
    'tpope/vim-abolish',
  },
  -- rust
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
  },
}

-- Gets current Omarchy theme
local theme = dofile(vim.fn.expand '~/.config/omarchy/current/theme/neovim.lua')

local function is_lazyvim(entry)
  return type(entry) == 'table' and entry[1] == 'LazyVim/LazyVim'
end

local theme_plugins = {}

if type(theme) == 'table' then
  -- check if it's a list (array part)
  if theme[1] ~= nil then
    -- iterate over each element in the list
    for _, spec in ipairs(theme) do
      if not is_lazyvim(spec) then
        table.insert(theme_plugins, spec)
      end
    end
  else
    -- it's a single table plugin spec (not an array)
    if not is_lazyvim(theme) then
      table.insert(theme_plugins, theme)
    end
  end
end

vim.list_extend(base, theme_plugins)

-- See the kickstart.nvim README for more information
return base
