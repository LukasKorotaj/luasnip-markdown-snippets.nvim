local ls = require("luasnip")

-- 1. Use pcall for error handling
local ok, math_snippets = pcall(require, "luasnip-markdown-snippets.luasnippets.tex.math")
local ok2, math_commands = pcall(require, "luasnip-markdown-snippets.luasnippets.tex.math-commands")
local ok3, delimiters = pcall(require, "luasnip-markdown-snippets.luasnippets.tex.delimiters")

-- 2. Validate loaded snippets
if not (ok and ok2 and ok3) then
	vim.notify("Failed to load LaTeX math snippets", vim.log.levels.ERROR)
	return
end

-- 3. Merge snippets first
local merged = vim.tbl_extend("force", math_snippets, math_commands, delimiters)

-- 4. Add with proper configuration
ls.add_snippets("markdown", merged, {
	type = "autosnippets",
	key = "__markdown_latex_math",
	default_priority = 300,
	-- Add math context condition
	condition = function()
		return require("your-module.math-conditions").in_math()
	end,
})
