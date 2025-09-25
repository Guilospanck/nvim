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

-- ##################################### THEME related ##########################################

local theme = {}

local omarchy_current_theme_path = vim.fn.expand '~/.config/omarchy/current/theme/neovim.lua'
if vim.loop.fs_stat(omarchy_current_theme_path) then
  -- Gets current Omarchy theme
  theme = dofile(omarchy_current_theme_path)
end

local function is_lazyvim(entry)
  return type(entry) == 'table' and entry[1] == 'LazyVim/LazyVim'
end

local theme_plugins = {}

if type(theme) == 'table' and next(theme) ~= nil then
  if theme[1] ~= nil then
    for _, spec in ipairs(theme) do
      if not is_lazyvim(spec) then
        table.insert(theme_plugins, spec)
      end
    end
  else
    if not is_lazyvim(theme) then
      table.insert(theme_plugins, theme)
    end
  end
end

-- If at this point the theme_plugins is still nil,
-- we try to get it either from Omarchy "THEME_NAME" env
-- or, if in another OS, default to catppuccin
if next(theme_plugins) == nil then
  -- NOTE: for this to work, we had to change Omarchy
  -- `omarchy-theme-set` and add
  -- `echo "$THEME_NAME" > "$CURRENT_THEME_DIR/theme_name"`
  local f = io.open(os.getenv 'HOME' .. '/.config/omarchy/current/theme/theme_name', 'r')
  local theme_name = f and f:read '*l' or 'catppuccin'
  if f then
    f:close()
  end

  if theme_name == 'tokyo-night' then
    theme_plugins = {
      {
        'folke/tokyonight.nvim',
        priority = 1000,
        init = function()
          vim.cmd.colorscheme 'tokyonight-storm'
          vim.cmd.hi 'Comment gui=none'
        end,
      },
    }
  elseif theme_name == 'rose-pine' then
    theme_plugins = {
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

          require('rose-pine').setup {
            disable_background = true,
            highlight_groups = {
              MiniStatuslineDevinfo = { fg = 'iris', bg = 'overlay' },
              MiniStatuslineFilename = { fg = 'gold', bg = 'surface' },
              LspReferenceRead = { bg = '#000000' },
              LspReferenceText = { bg = '#000000' },
              LspReferenceWrite = { bg = '#000000' },
              CursorLine = { bg = '#100E1B' },
            },
          }

          colorMyPencils()
        end,
      },
    }
  else -- default to catppuccin
    theme_plugins = {
      {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        config = function()
          local function colorMyPencils(color)
            color = color or 'catppuccin-mocha'
            vim.cmd.colorscheme(color)
            vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
          end

          colorMyPencils()
        end,
      },
    }
  end
end

vim.list_extend(base, theme_plugins)

-- ##################################### THEME related ##########################################

return base
