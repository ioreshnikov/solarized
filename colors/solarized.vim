let g:colors_name="solarized"

" By setting our module to nil, we clear lua's cache,
" which means the require ahead will *always* occur.
"
" This isn't strictly required but it can be a useful trick if you are
" incrementally editing your config a lot and want to be sure your themes
" changes are being picked up without restarting neovim.
"
" Note if you're working in on your theme and have :Lushify'd the buffer,
" your changes will be applied with our without the following line.
"
" The performance impact of this call can be measured in the hundreds of
" *nanoseconds* and such could be considered "production safe".
lua package.loaded['color'] = nil
lua package.loaded['lush_theme.solarized'] = nil

" include our theme file and pass it to lush to apply
lua require('lush')(require('lush_theme.solarized'))

" Automatically darken the terminal
autocmd TermOpen * setlocal winhighlight=Normal:NormalSB,SignColumn:SignColumnSB

" Set up terminal colors
lua << EOF
color = require('color')
vim.g.terminal_color_0 = color.base02.hex
vim.g.terminal_color_8 = color.base03.hex

vim.g.terminal_color_7 = color.base2.hex
vim.g.terminal_color_15 = color.base3.hex

vim.g.terminal_color_1 = color.red.hex
vim.g.terminal_color_9 = color.orange.hex

vim.g.terminal_color_2 = color.green.hex
vim.g.terminal_color_10 = color.base01.hex

vim.g.terminal_color_3 = color.yellow.hex
vim.g.terminal_color_11 = color.base00.hex

vim.g.terminal_color_4 = color.blue.hex
vim.g.terminal_color_12 = color.base0.hex

vim.g.terminal_color_5 = color.magenta.hex
vim.g.terminal_color_13 = color.violet.hex

vim.g.terminal_color_6 = color.cyan.hex
vim.g.terminal_color_14 = color.base1.hex
EOF
