require("core.options")
require("core.keymaps")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	spec = {
		{ import = "plugins.gruvbox" },
		{ import = "plugins.neotree" },
		{ import = "plugins.treesitter" },
		{ import = "plugins.telescope" },
		{ import = "plugins.dressing" },
		{ import = "plugins.nvim-cmp" },
		{ import = "plugins.lsp" },
		{ import = "plugins.mason" },
		{ import = "plugins.none-ls" },
		{ import = "plugins.nvim-dap" },
		{ import = "plugins.autopairs" },
		{ import = "plugins.lualine" },
		{ import = "plugins.barbar" },
		{ import = "plugins.gitsigns" },
		{ import = "plugins.alpha" },
		{ import = "plugins.indent-blankline" },
	},
	install = { colorscheme = { "gruvbox" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
