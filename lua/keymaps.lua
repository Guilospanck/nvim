-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--

-- Map CMD B (in Alacritty) to open explore
vim.keymap.set('n', '', vim.cmd.Lex)

-- -- This enables us to move the current line to above or below
vim.keymap.set('v', '', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '', ":m '>+1<CR>gv=gv")

-- This allow us to substitute ALL occurrences of current word under cursor
-- It uses CMD Shift L (mapped in Alacritty)
-- Visual mode from: adapted from https://stackoverflow.com/a/77622213/9782182
table.unpack = table.unpack or unpack
local function get_visual()
  local _, ls, cs = table.unpack(vim.fn.getpos 'v')
  local _, le, ce = table.unpack(vim.fn.getpos '.')
  if cs > ce then
    local temp = cs
    cs = ce
    ce = temp
  end
  if ls > le then
    local temp = ls
    ls = le
    le = temp
  end
  return vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
end
vim.keymap.set('n', '', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('v', '', function()
  local pattern = table.concat(get_visual())
  -- escape regex and line endings
  pattern = vim.fn.substitute(vim.fn.escape(pattern, '^$.*\\/~[]'), '\n', '\\n', 'g')
  -- send parsed substitution command to command line
  vim.api.nvim_input('<Esc>:%s/' .. pattern .. '//<Left>')
end)

-- Copy full absolute path of current file
-- CTRL SHIFT a
vim.keymap.set({ 'n', 'v' }, '', ':let @+ = expand("%:p")<CR>')

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- vim.keymap.set('n', '<C-`>', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Toggle to last file (uses Alt TAB mapped in Alacritty)
vim.keymap.set('n', '', '<C-^>', { desc = 'Toggle windows' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--
--  See `:help wincmd` for a list of all window commands

local function toggleMaximizeWindow()
  local win_id = vim.api.nvim_get_current_win()
  local current_height = vim.api.nvim_win_get_height(win_id)
  local max_height = vim.o.lines - vim.o.cmdheight - 2
  local normal_height = 20

  if current_height > normal_height then
    vim.api.nvim_win_set_height(win_id, normal_height)
  else
    vim.api.nvim_win_set_height(win_id, max_height)
  end
end -- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-^>', toggleMaximizeWindow, { desc = 'Expand window vertically' })
--
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
