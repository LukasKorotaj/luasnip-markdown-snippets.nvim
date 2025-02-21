-- [
-- snip_env + autosnippets
-- ]
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

require("luasnip").filetype_extend("markdown", { "tex" })

--[
-- personal imports
--]
local tex = require("luasnip-markdown-snippets.luasnippets.tex.utils.conditions")
local scaffolding = require("luasnip-markdown-snippets.luasnippets.tex.utils.scaffolding")

-- brackets
local brackets = {
	a = { "\\langle", "\\rangle" },
	A = { "Angle", "Angle" },
	b = { "brack", "brack" },
	B = { "Brack", "Brack" },
	c = { "brace", "brace" },
	m = { "|", "|" },
	p = { "(", ")" },
}

M = {
	autosnippet(
		{ trig = "lr([aAbBcmp])", name = "left right", dscr = "left right delimiters", regTrig = true, hidden = true },
		fmta(
			[[
    \left<> <> \right<><>
    ]],
			{
				f(function(_, snip)
					local cap = snip.captures[1] or "p"
					return brackets[cap][1]
				end),
				d(1, scaffolding.get_visual),
				f(function(_, snip)
					local cap = snip.captures[1] or "p"
					return brackets[cap][2]
				end),
				i(0),
			}
		),
		{ condition = tex.in_math, show_condition = tex.in_math }
	),
}

return M
