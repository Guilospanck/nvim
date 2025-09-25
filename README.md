# nvim

This is my nvim configuration.

> [!NOTE]  
> There's a `omarchy` branch that is supposed to be used with `Omarchy` (due to themes and whatnot). Other than that, just use code from `master`.

> [!NOTE]  
> Most of the commands shortcuts here uses keybinds for macOS that were defined using Alacritty terminal. Check the [dotfiles](https://github.com/Guilospanck/dotfiles) for more.

## How it looks

![alt text](img/nvim.png)
![alt text](img/nvim2.png)

## Plugins

A non-exhaustive list of plugins used:

- UndoTree
- Telescope
- Treesitter
- Theme: it changes, but in the screenshots it's rose-pine.

For more info check the `lua/lazy-plugins.lua` and `lua/custom/plugins/init.lua` for the whole list.

> [!INFO]  
> To have transparent background you need to:
> - Go to `./lua/custom/plugins/init.lua` and enable the `bg = 'none'` for your theme. Example:
> ```
>        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
>        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
>
> ```
> - Be sure to also enable the transparent background for your terminal. In alacritty you do it by:
> a) 
> ```
>    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
>    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
> ```
> b) also change the `opacity` (!important) 
