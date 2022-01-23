-- Tree

local tree_cb = require'nvim-tree.config'.nvim_tree_callback

require'nvim-tree'.setup {
  view = {
    mappings = {
      list = {
        { key = "u", cb = tree_cb("dir_up") },
      }
    }
  }
}
