if vim.g.vscode then
	return {}
end

return {
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-ts-autotag",
			"RRethy/nvim-treesitter-endwise",
			"m-demare/hlargs.nvim",
		},
		config = function()
			-- pcall(require("nvim-treesitter.install").update({ with_sync = true }))
			require("nvim-treesitter.configs").setup({
				-- Make the stupid diagnostics go away
				modules = {},
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = {
					"lua",
					"vimdoc",
					"vim",
					"markdown",
					"markdown_inline",
					"regex",
					"query",
				},
				-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
				auto_install = true,
				sync_install = false,
				ignore_install = {},
				highlight = {
					enable = true,
					-- disable = { "log", "eruby", "embedded_template" },
					-- disable = { "log", "gitcommit" },
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = { "gitcommit" },
					use_languagetree = false,
				},
				indent = { enable = true, disable = { "python", "ruby", "eruby" } },
				incremental_selection = {
					enable = true,
					keymaps = {
						scope_incremental = false,
						init_selection = "+",
						node_incremental = "+",
						node_decremental = "_",
					},
				},
				matchup = {
					enabled = true,
					enable_quotes = true,
				},
				autotag = {
					enable = true,
					filetypes = { "html", "xml", "javascript", "javascriptreact", "typescript", "typescriptreact", "eruby",
						"markdown", "tsx", "jsx" },
				},
				endwise = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim

						keymaps = {
							["am"] = "@function.outer",
							["im"] = "@function.inner",
							["as"] = "@scope.outer",
							["is"] = "@scope.inner",
							["ak"] = { query = "@block.outer", desc = "around block" },
							["ik"] = { query = "@block.inner", desc = "inside block" },
						},
					},
					move = {
						enable = true,
						goto_next_start = {
							["]k"] = { query = "@block.outer", desc = "Next block start" },
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
							--
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						},
						goto_next_end = {
							["]K"] = { query = "@block.outer", desc = "Next block end" },
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[k"] = { query = "@block.outer", desc = "Previous block start" },
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
							--
							["[s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						},
						goto_previous_end = {
							["[K"] = { query = "@block.outer", desc = "Previous block end" },
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
							--
							["[S"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
						},
					},
					playground = {
						enable = true,
						updatetime = 25,
					},
					query_linter = {
						enable = true,
						use_virtual_text = true,
						lint_events = { "BufWrite", "CursorHold" },
					},
				},
			})

			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

			-- Repeat movement with ; and ,
			-- ensure ; goes forward and , goes backward regardless of the last direction
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)

			require('ts_context_commentstring').setup(
				{ enable = true, enable_autocmd = false })   -- Enable commentstring
			vim.g.skip_ts_context_commentstring_module = true -- Increase performance
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		lazy = true,
	},

	{
		"nvim-treesitter/playground",
		lazy = true,
	},

	{
		"RRethy/nvim-treesitter-endwise",
		lazy = true,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = true,
		opts = {
			enable = true,
			max_lines = 4,
		},
	}, -- Show function/scope in windowbar

	{
		"m-demare/hlargs.nvim",
		lazy = true,
		opts = {
			extras = {
				named_parameters = true,
			},
		},
	}, -- Highlight method args separately
}
