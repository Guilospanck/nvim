-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        pickers = {
          live_grep = {
            additional_args = function()
              return {
                '--hidden',
                '--no-ignore',
                '-g',
                '!.git',
                '-g',
                '!node_modules',
                '-g',
                '!target',
                '-g',
                '!*.lock',
                '-g',
                '!coverage',
                '-g',
                '!.cargo',
                '-g',
                '!.godot',
                '-g',
                '!assets',
                '-g',
                '!.next',
                '-g',
                '!pnpm-lock.yaml',
                '-g',
                '!allure-results',
                '-g',
                '!build',
              }
            end,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        defaults = {
          file_ignore_patterns = { '.cargo', '.godot', 'assets', '.next', 'pnpm-lock.yaml' },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      -- See `:help telescope.builtin.live_grep()` for information about particular keys
      local builtin = require 'telescope.builtin'

      local function find_checking_git(fn, opts)
        local root = string.gsub(vim.fn.system 'git rev-parse --show-toplevel', '\n', '')
        if vim.v.shell_error == 0 then
          opts['cwd'] = root
        end

        fn(opts)
      end

      -- Mapped with CMD P via Alacritty
      vim.keymap.set('n', '', function()
        find_checking_git(builtin.find_files, {
          find_command = {
            'fd',
            '--type',
            'file',
            '--hidden',
            '--no-ignore',
            '--exclude',
            '.git',
            '--exclude',
            'node_modules',
            '--exclude',
            'target',
            '--exclude',
            '*.lock',
            '--exclude',
            'coverage',
            '--exclude',
            '.cargo',
            '--exclude',
            '.godot',
            '--exclude',
            'assets',
            '--exclude',
            '.next',
            '--exclude',
            'pnpm-lock.yaml',
            '--exclude',
            'allure-results',
            '--exclude',
            'build',
          },
        })
      end, { desc = 'Search Files [CMD P]' })

      --  Mapped with CMD F via Alacritty
      vim.keymap.set('n', '', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = true,
        })
      end, { desc = 'Fuzzily search in current buffer [CMD F]' })

      --  Mapped with CMD Shift F via Alacritty
      vim.keymap.set('n', '', function()
        find_checking_git(builtin.live_grep, {
          grep_open_files = false,
          prompt_title = 'Live Grep in Files',
        })
      end, { desc = 'Search in Files [CMD Shift F]' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      -- Check if Trouble is better (and if it is the same)
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
