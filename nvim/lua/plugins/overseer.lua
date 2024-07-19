return {
	{
		"stevearc/overseer.nvim",
		keys = {
			{
				"<leader>k",
				function()
					local util = require("user.util")
					util.invoke_cmd_with_cursor(function()
						require("overseer").toggle({ enter = false })
					end)
				end,
				{ desc = "Toggle overseer" },
			},
		},
		opts = {
			strategy = {
				"toggleterm",
				close_on_exit = false,
				open_on_start = false,
				hidden = true,
			},
			task_list = {
				bindings = {
					["<C-l>"] = false,
					["<C-h>"] = false,
					["<space>"] = "IncreaseDetail",
					["-"] = "DecreaseDetail",
					["<C-d>"] = "ScrollOutputDown",
					["<C-u>"] = "ScrollOutputUp",
					["o"] = false,
				},
				min_width = { 80, 0.50 },
				default_detail = 2,
			},

			form = {
				win_opts = {
					winblend = 5,
				},
			},

			component_aliases = {
				default_neotest = {
					{ "display_duration", detail_level = 2 },
					"on_output_summarize",
					"on_exit_set_status",
					"on_complete_notify",
					"on_complete_dispose",
				},
			},
		},
	},
}
