local cmd = vim.cmd
local api = vim.api
local g = vim.g
local opt = vim.opt

utils = require('utils')

g.mapleader = ","

cmd([[
  filetype plugin indent on
]])

opt.termguicolors = true
opt.encoding = "utf-8"
opt.autochdir = true
opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.hidden = true
opt.cmdheight = 2
opt.updatetime = 300
opt.clipboard = "unnamed"
opt.shortmess:append("c")

-- Python settings

cmd([[
autocmd FileType python setlocal 
\ tabstop=2
\ softtabstop=2
\ shiftwidth=2
\ textwidth=80
\ smarttab
\ expandtab
]])

-- Colorscheme

g["ayucolor"] = "mirage"
cmd 'colorscheme ayu'
