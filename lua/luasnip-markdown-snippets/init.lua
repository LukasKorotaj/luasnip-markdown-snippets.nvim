local current_file = debug.getinfo(1).source:sub(2)
local snippet_path = current_file:gsub("init%.lua$", "luasnippets")

if vim.fn.isdirectory(snippet_path) == 1 then
	require("luasnip.loaders.from_lua").lazy_load({
		paths = { snippet_path },
	})
else
	vim.notify("Luasnippets directory missing: " .. snippet_path, vim.log.levels.ERROR)
end

require("luasnip").filetype_extend("markdown", { "tex" })
