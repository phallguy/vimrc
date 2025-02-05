if vim.g.vscode then
	return {}
end

return {
	{
		"folke/noice.nvim",
		-- enabled = false,
		config = function()
			require("noice").setup({
				-- debug = true,
				notify = {
					-- view = "mini",
					enabled = false,
				},
				messages = {
					enabled = true,
				},
				lsp = {
					enabled = false,
				  signature = {
				    enabled = false,
				  }
				},
				signature = {
					enabled = false,
				},
				popupmenu = {
					enabled = false,
				},
				views = {
					-- mini = {
					-- 	backend = "mini",
					-- 	relative = "editor",
					-- 	align = "message-right",
					-- 	timeout = 3000,
					-- 	-- reverse = true,
					-- 	focusable = false,
					-- 	position = {
					-- 		row = -1,
					-- 		col = "100%",
					-- 		-- col = 0,
					-- 	},
					-- 	size = "auto",
					-- 	border = {
					-- 		style = "none",
					-- 	},
					-- 	zindex = 60,
					-- 	win_options = {
					-- 		winblend = 0,
					-- 		-- winhighlight = {
					-- 		-- 	Normal = "NoiceMini",
					-- 		-- 	IncSearch = "",
					-- 		-- 	CurSearch = "",
					-- 		-- 	Search = "",
					-- 		-- },
					-- 	},
					-- },
					cmdline_popup = {
						-- backend = "popup",
						-- relative = "editor",
						-- focusable = false,
						-- enter = false,
						-- zindex = 60,
						position = {
							row = "50%",
							col = "50%",
						},
						size = {
							min_width = 60,
							width = "auto",
							height = "auto",
						},
						border = {
							style = "none",
							padding = { 2, 4 },
						},
						filter_options = {},
						win_options = {
							winblend = 0,
						},
					},
					popupmenu = {
						enabled = true,
					},
					popup = {
						enabled = true,
						size = {
							width = "auto",
						},
					},
					hover = {
						size = {
							max_width = 80,
						},
						position = {
							row = 3,
							col = 0,
						},
					},
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
}
