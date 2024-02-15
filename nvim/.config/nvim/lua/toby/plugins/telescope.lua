return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local trouble = require("trouble.providers.telescope")

		telescope.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-t>"] = trouble.open_with_trouble,
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
					n = {
						["<C-t>"] = trouble.open_with_trouble,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
		keymap.set(
			"n",
			"<leader>xw",
			"<cmd>TroubleToggle workspace_diagnostics<cr>",
			{ desc = "Toggle workspace diagnostics" }
		)
		keymap.set(
			"n",
			"<leader>xd",
			"<cmd>TroubleToggle document_diagnostics<cr>",
			{ desc = "Toggle document diagnostics" }
		)
		keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix" })
		keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Toggle loclist" })
		keymap.set("n", "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", { desc = "Toggle lsp references" })
	end,
}
