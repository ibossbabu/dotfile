return {
  "nvimtools/none-ls.nvim",
   dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
local null_ls = require("null-ls")
   require('mason-null-ls').setup {
      ensure_installed = {
        'stylua',   -- lua formatter
        'goimports',
        'gofumpt',
        'golangci_lint',
        "prettier",
      },
      -- auto-install configured formatters & linters (with null-ls)
      automatic_installation = true,
    }
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.code_actions.gomodifytags,
        null_ls.builtins.code_actions.impl,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.gofumpt,
    },
})

  vim.keymap.set( 'n', '<leader>gf', vim.lsp.buf.format, {})
 end
}
