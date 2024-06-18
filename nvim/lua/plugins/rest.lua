return {
	{
		"vhyrro/luarocks.nvim",
		lazy = true,
		priority = 1000,
		config = true,
		opts = {
			rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
		},
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		config = function()
			require("rest-nvim").setup()
			require("telescope").load_extension("rest")
		end,
	},
}
