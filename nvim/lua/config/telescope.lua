local M = {}

function M.setup()
	local status, telescope = pcall(require, "telescope")
	if (not status) then return end
	local actions = require('telescope.actions')
	local builtin = require("telescope.builtin")

	local function telescope_buffer_dir()
		return vim.fn.expand('%:p:h')
	end

	local fb_actions = require "telescope".extensions.file_browser.actions

	local telescope_custom_actions = {}

	function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
		local action_state = require "telescope.actions.state"
		local picker = action_state.get_current_picker(prompt_bufnr)
		local selected_entry = action_state.get_selected_entry()
		local num_selections = #picker:get_multi_selection()
		if not num_selections or num_selections <= 1 then
			actions.add_selection(prompt_bufnr)
		end
		actions.send_selected_to_qflist(prompt_bufnr)
		vim.cmd("cfdo " .. open_cmd)
	end
	function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
		telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
	end
	function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
		telescope_custom_actions._multiopen(prompt_bufnr, "split")
	end
	function telescope_custom_actions.multi_selection_open_tab(prompt_bufnr)
		telescope_custom_actions._multiopen(prompt_bufnr, "tabe")
	end
	function telescope_custom_actions.multi_selection_open(prompt_bufnr)
		telescope_custom_actions._multiopen(prompt_bufnr, "edit")
	end

	telescope.setup {
		defaults = {
			mappings = {
				n = {
					["t"] = telescope_custom_actions.multi_selection_open_tab,
					["q"] = actions.close,
				},
			},
		},
		extensions = {
			file_browser = {
				theme = "dropdown",
				-- disables netrw and use telescope-file-browser in its place
				hijack_netrw = true,
				mappings = {
					-- your custom insert mode mappings
					["i"] = {
						["<C-w>"] = function() vim.cmd('normal vbd') end,
					},
					["n"] = {
						-- your custom normal mode mappings
						["N"] = fb_actions.create,
						["h"] = fb_actions.goto_parent_dir,
						["/"] = function()
						vim.cmd('startinsert')
						end
					},
				},
			},
		},

	}
	telescope.load_extension("file_browser")

	-- keymaps
	vim.keymap.set('n', ';f',
		function()
			builtin.find_files({
				no_ignore = false,
				hidden = true
			})
	end)
	vim.keymap.set('n', ';r', function()
		builtin.live_grep()
	end)
	vim.keymap.set('n', '\\\\', function()
		builtin.buffers()
	end)
	vim.keymap.set('n', ';t', function()
		builtin.help_tags()
	end)
	vim.keymap.set('n', ';;', function()
		builtin.resume()
	end)
	vim.keymap.set('n', ';e', function()
		builtin.diagnostics()
	end)
	vim.keymap.set("n", "sf", function()
		telescope.extensions.file_browser.file_browser({
			path = "%:p:h",
			cwd = telescope_buffer_dir(),
			respect_gitignore = false,
			hidden = true,
			grouped = true,
			previewer = false,
			initial_mode = "normal",
			layout_config = { height = 40 }
		})
	end)
end

return M
