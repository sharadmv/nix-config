-- Tree

local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vim.g.nvim_tree_bindings = {
  { key = "u", cb = tree_cb("dir_up") },
}

