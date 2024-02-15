return {
	"barrett-ruth/live-server.nvim",
	lazy = true,
	config = function()
		-- Setup configuration for live-server
		require("live-server").setup({
			-- Specify the arguments to pass to live-server
			args = { "--port=7567", "--browser=Google Chrome" },
		})

		-- Define keyboard shortcuts for starting and stopping the live server
		vim.keymap.set(
			"n",
			"<leader>le",
			function()
				require("live-server").start()
			end, -- Start server with specified args
			{ silent = true, noremap = true, desc = "Starts LiveServer" }
		)
		vim.keymap.set(
			"n",
			"<leader>ls",
			function()
				require("live-server").stop()
			end, -- Stop the server
			{ silent = true, noremap = true, desc = "Stops LiveServer" }
		)
	end,
}
