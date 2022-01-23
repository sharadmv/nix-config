vim.o.completeopt = "menuone,noselect"

local cmp = require('cmp')
cmp.setup {
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
  }
}
