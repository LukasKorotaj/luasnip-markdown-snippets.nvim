local M = {}

local conditions = require("luasnip-markdown-snippets.luasnippets.tex.utils.conditions")

M.in_math = conditions.in_math

function M.setup(user_opts)
	user_opts = user_opts or {}

	-- Load default snippets
	local current_file = debug.getinfo(1).source:sub(2)
	local snippet_path = current_file:gsub("init%.lua$", "luasnippets")

	if vim.fn.isdirectory(snippet_path) == 1 then
		require("luasnip.loaders.from_lua").lazy_load({
			paths = { snippet_path },
		})
	else
		vim.notify("Luasnippets directory missing: " .. snippet_path, vim.log.levels.ERROR)
	end

	-- Add user snippets with higher priority to override defaults
	local user_snippets = user_opts.snippets or {}
	for ft, snippets in pairs(user_snippets) do
		require("luasnip").add_snippets(ft, snippets, {
			default_priority = user_opts.priority or 1001, -- Higher than default 1000
		})
	end

	require("luasnip").filetype_extend("markdown", { "tex" })
end

return M
