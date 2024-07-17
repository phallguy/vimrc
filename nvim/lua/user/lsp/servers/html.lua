local capabilities = require("user.lsp.capabilities")

require("lspconfig").html.setup({
	filetypes = { "html", "erb", "eruby" },
	embeddedLanguages = {
		css = true,
		javascript = true,
		ruby = true,
	},
	init_options = {
		provideFormatter = false,
	},
})
