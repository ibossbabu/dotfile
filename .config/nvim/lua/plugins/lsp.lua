return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" }, -- Required
		{ "hrsh7th/cmp-nvim-lsp" }, -- Required
	},
	config = function()
    local lspconfig = require("lspconfig")
		local lsp = require("lsp-zero")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local mason_lspconfig = require("mason-lspconfig")

		lsp.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = false, silent = true}

			vim.keymap.set("n", "gr", function()
				vim.lsp.buf.references()
			end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))
			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition" }))
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))
			vim.keymap.set("n", "<leader>ws", function()
				vim.lsp.buf.workspace_symbol()
			end, vim.tbl_deep_extend("force", opts, { desc = "LSP Workspace Symbol" }))
			vim.keymap.set("n", "<leader>d", function()
				vim.diagnostic.setloclist()
			end, vim.tbl_deep_extend("force", opts, { desc = "LSP Show Diagnostics" }))
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_next()
			end, vim.tbl_deep_extend("force", opts, { desc = "Next Diagnostic" }))
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_prev()
			end, vim.tbl_deep_extend("force", opts, { desc = "Previous Diagnostic" }))
			vim.keymap.set("n", "<leader>ca", function()
				vim.lsp.buf.code_action()
			end, vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" }))
			vim.keymap.set("n", "<leader>rr", function()
				vim.lsp.buf.references()
			end, vim.tbl_deep_extend("force", opts, { desc = "LSP References" }))
			vim.keymap.set("n", "<leader>rn", function()
				vim.lsp.buf.rename()
			end, vim.tbl_deep_extend("force", opts, { desc = "LSP Rename" }))
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, vim.tbl_deep_extend("force", opts, { desc = "LSP Signature Help" }))
		end)

      local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
      mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
	end,
}
