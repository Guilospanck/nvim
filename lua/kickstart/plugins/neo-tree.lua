-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  init = function()
    -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
    -- because `cwd` is not set up properly.
    vim.api.nvim_create_autocmd('BufEnter', {
      group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
      desc = 'Start Neo-tree with directory',
      once = true,
      callback = function()
        if package.loaded['neo-tree'] then
          return
        end

        local stats = vim.uv.fs_stat(vim.fn.argv(0))
        if stats and stats.type == 'directory' then
          require 'neo-tree'
        end
      end,
    })
  end,
  keys = {
    -- CMD B mapped with Alacritty
    { '', ':Neotree reveal_force_cwd toggle<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    buffers = { follow_current_file = { enable = true } },
    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      window = {
        position = 'right',
        -- mappings = {
        --   -- CMD B mapped with Alacritty
        --   [''] = 'close_window',
        -- },
      },
      hijack_netrw_behavior = 'open_current',
    },
  },
}
