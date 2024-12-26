return {
  {
    "williamboman/mason.nvim",
    build = function()
      pcall(vim.cmd, "MasonUpdate")
    end,
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup({
        ensure_installed = {
          "gopls",
          "goimports",
          "gofumpt",
          "gomodifytags",
          "impl",
        },
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "gopls",
          "delve",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "gopls",
          "html",
          "eslint",
          "cssls",
          "emmet_ls",
          "jsonls",
          "ts_ls",
        },
      })
    end,
  },
}
