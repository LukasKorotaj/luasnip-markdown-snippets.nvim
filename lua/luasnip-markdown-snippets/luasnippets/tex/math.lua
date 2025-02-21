-- [
-- snip_env + autosnippets
-- ]
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmta = require("luasnip.extras.fmt").fmta
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

require("luasnip").filetype_extend("markdown", { "tex" })

-- [
-- personal imports
-- ]
local tex = require("luasnip-markdown-snippets.luasnippets.tex.utils.conditions")
local line_begin = require("luasnip.extras.conditions.expand").line_begin

-- Generating functions for Matrix/Cases - thanks L3MON4D3!
local generate_matrix = function(snip)
	local rows = tonumber(snip.captures[2])
	local cols = tonumber(snip.captures[3])
	local nodes = {}
	local ins_indx = 1
	for j = 1, rows do
		table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
		ins_indx = ins_indx + 1
		for k = 2, cols do
			table.insert(nodes, t(" & "))
			table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
			ins_indx = ins_indx + 1
		end
		table.insert(nodes, t({ "\\\\", "" }))
	end
	-- fix last node.
	nodes[#nodes] = t("\\\\")
	return sn(nil, nodes)
end

-- update for cases
local generate_cases = function(snip)
	local rows = tonumber(snip.captures[1]) or 2 -- default option 2 for cases
	local cols = 2 -- fix to 2 cols
	local nodes = {}
	local ins_indx = 1
	for j = 1, rows do
		table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
		ins_indx = ins_indx + 1
		for k = 2, cols do
			table.insert(nodes, t(" & "))
			table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
			ins_indx = ins_indx + 1
		end
		table.insert(nodes, t({ "\\\\", "" }))
	end
	-- fix last node.
	table.remove(nodes, #nodes)
	return sn(nil, nodes)
end

M = {
	-- Math modes
	s(
		{ trig = "mk", name = "$..$", dscr = "inline math" },
		fmta(
			[[
    $<>$<>
    ]],
			{ i(1), i(0) }
		)
	),

	s(
		{ trig = "dm", name = "$$..$$", dscr = "display math" },
		fmta(
			[[ 
    $$ 
    <>
    $$
    <>]],
			{ i(1), i(0) }
		)
	),

	s(
		{ trig = "ali", name = "align(|*|ed)", dscr = "align math" },
		fmta(
			[[ 
    \begin{align<>}
    <>
    .\end{align<>}
    ]],
			{ c(1, { t("*"), t(""), t("ed") }), i(2), rep(1) }
		) -- in order of least-most used
	),

	s(
		{ trig = "==", name = "&= align", dscr = "&= align" },
		fmta(
			[[
    &<> <> \\
    ]],
			{ c(1, { t("="), t("\\leq"), i(1) }), i(2) }
		)
	),

	s(
		{ trig = "gat", name = "gather(|*|ed)", dscr = "gather math" },
		fmta(
			[[ 
    \begin{gather<>}
    <>
    .\end{gather<>}
    ]],
			{ c(1, { t("*"), t(""), t("ed") }), i(2), rep(1) }
		)
	),

	s(
		{ trig = "eqn", name = "equation(|*)", dscr = "equation math" },
		fmta(
			[[
    \begin{equation<>}
    <>
    .\end{equation<>}
    ]],
			{ c(1, { t("*"), t("") }), i(2), rep(1) }
		)
	),

	-- Matrices and Cases
	s(
		{
			trig = "([bBpvV])mat(%d+)x(%d+)([ar])",
			name = "[bBpvV]matrix",
			dscr = "matrices",
			regTrig = true,
			hidden = true,
		},
		fmta(
			[[
    \begin{<>}<>
    <>
    \end{<>}]],
			{
				f(function(_, snip)
					return snip.captures[1] .. "matrix"
				end),
				f(function(_, snip)
					if snip.captures[4] == "a" then
						local out = string.rep("c", tonumber(snip.captures[3]) - 1)
						return "[" .. out .. "|c]"
					end
					return ""
				end),
				d(1, generate_matrix),
				f(function(_, snip)
					return snip.captures[1] .. "matrix"
				end),
			}
		),
		{ condition = tex.in_math, show_condition = tex.in_math }
	),

	autosnippet(
		{ trig = "(%d?)cases", name = "cases", dscr = "cases", regTrig = true, hidden = true },
		fmta(
			[[
    \begin{cases}
    <>
    .\end{cases}
    ]],
			{ d(1, generate_cases) }
		),
		{ condition = tex.in_math, show_condition = tex.in_math }
	),
}

return M
