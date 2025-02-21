-- Basically a list of snippet-generating functions or other dynamics that are used frequently
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
local fmta = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

M = {}

-- postfix helper function - generates dynamic node
local generate_postfix_dynamicnode = function(_, parent, _, user_arg1, user_arg2)
	local capture = parent.snippet.env.POSTFIX_MATCH
	if #capture > 0 then
		return sn(
			nil,
			fmta(
				[[
        <><><><>
        ]],
				{ t(user_arg1), t(capture), t(user_arg2), i(0) }
			)
		)
	else
		local visual_placeholder = parent.snippet.env.SELECT_RAW
		return sn(
			nil,
			fmta(
				[[
        <><><><>
        ]],
				{ t(user_arg1), i(1, visual_placeholder), t(user_arg2), i(0) }
			)
		)
	end
end

M.get_visual = function(parent)
	-- Safely retrieve SELECT_RAW if available, defaulting to an empty string.
	local select_raw = ""
	if parent.snippet and parent.snippet.env and parent.snippet.env.SELECT_RAW then
		select_raw = parent.snippet.env.SELECT_RAW
	end

	if #select_raw > 0 then
		return sn(nil, i(1, select_raw))
	else
		return sn(nil, i(1))
	end
end
-- Auto backslash - thanks kunzaatko! (ref: https://github.com/kunzaatko/nvim-dots/blob/trunk/lua/snippets/tex/utils/snippet_templates.lua)
M.auto_backslash_snippet = function(context, opts)
	opts = opts or {}
	if not context.trig then
		error("context doesn't include a `trig` key which is mandatory", 2)
	end
	context.dscr = context.dscr or (context.trig .. "with automatic backslash")
	context.name = context.name or context.trig
	context.docstring = context.docstring or ([[\]] .. context.trig)
	context.trigEngine = "ecma"
	context.trig = "(?<!\\\\)" .. "(" .. context.trig .. ")"
	return autosnippet(
		context,
		fmta(
			[[
    \<><>
    ]],
			{ f(function(_, snip)
				return snip.captures[1]
			end), i(0) }
		),
		opts
	)
end

-- Auto symbol
M.symbol_snippet = function(context, command, opts)
	opts = opts or {}
	if not context.trig then
		error("context doesn't include a `trig` key which is mandatory", 2)
	end
	context.dscr = context.dscr or command
	context.name = context.name or command:gsub([[\]], "")
	context.docstring = context.docstring or (command .. [[{0}]])
	context.wordTrig = context.wordTrig or false
	local j, _ = string.find(command, context.trig)
	if j == 2 then -- command always starts with backslash
		context.trigEngine = "ecma"
		context.trig = "(?<!\\\\)" .. "(" .. context.trig .. ")"
		context.hidden = true
	end
	return autosnippet(context, t(command), opts)
end

-- single command with option
M.single_command_snippet = function(context, command, opts, ext)
	opts = opts or {}
	if not context.trig then
		error("context doesn't include a `trig` key which is mandatory", 2)
	end
	context.dscr = context.dscr or command
	context.name = context.name or context.dscr
	local docstring, offset, cnode, lnode
	if ext.choice == true then
		docstring = "[" .. [[(<1>)?]] .. "]" .. [[{]] .. [[<2>]] .. [[}]] .. [[<0>]]
		offset = 1
		cnode = c(1, { t(""), sn(nil, { t("["), i(1, "opt"), t("]") }) })
	else
		docstring = [[{]] .. [[<1>]] .. [[}]] .. [[<0>]]
	end
	if ext.label == true then
		docstring = [[{]] .. [[<1>]] .. [[}]] .. [[\label{(]] .. ext.short .. [[:<2>)?}]] .. [[<0>]]
		ext.short = ext.short or command
		lnode = c(2 + (offset or 0), {
			t(""),
			sn(
				nil,
				fmta(
					[[
        \label{<>:<>}
        ]],
					{ t(ext.short), i(1) }
				)
			),
		})
	end
	context.docstring = context.docstring or (command .. docstring)
	local j, _ = string.find(command, context.trig)
	if j == 2 then
		context.trigEngine = "ecma"
		context.trig = "(?<!\\\\)" .. "(" .. context.trig .. ")"
		context.hidden = true
	end
	-- stype = ext.stype or s
	return s(
		context,
		fmta(command .. [[<>{<>}<><>]], { cnode or t(""), i(1 + (offset or 0)), (lnode or t("")), i(0) }),
		opts
	)
end

M.postfix_snippet = function(context, command, opts)
	opts = opts or {}
	if not context.trig then
		error("context doesn't include a `trig` key which is mandatory", 2)
	end
	if not context.trig then
		error("context doesn't include a `trig` key which is mandatory", 2)
	end
	context.dscr = context.dscr
	context.name = context.name or context.dscr
	context.docstring = command.pre .. [[(POSTFIX_MATCH|VISUAL|<1>)]] .. command.post
	context.match_pattern = [[[%w%.%_%-%"%']*$]]
	local j, _ = string.find(command.pre, context.trig)
	if j == 2 then
		context.trigEngine = "ecma"
		context.trig = "(?<!\\\\)" .. "(" .. context.trig .. ")"
		context.hidden = true
	end
	return postfix(
		context,
		{ d(1, generate_postfix_dynamicnode, {}, { user_args = { command.pre, command.post } }) },
		opts
	)
end

return M
