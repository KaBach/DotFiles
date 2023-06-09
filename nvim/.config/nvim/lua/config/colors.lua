
vim.cmd.colorscheme 'tokyonight'
local colors = require('catppuccin.palettes.mocha')
vim.cmd.highlight { 'Tabline', 'guifg=' .. colors.green, 'guibg=' .. colors.mantle }

