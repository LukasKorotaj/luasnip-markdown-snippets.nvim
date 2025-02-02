--[
-- LuaSnip Conditions
--]
local ts = vim.treesitter

local M = {}

-- math / not math zones

function M.in_math()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row, col = unpack(cursor)
	row = row - 1 -- 0-based

	-- Get inline parser
	local inline_parser = ts.get_parser(bufnr, "markdown_inline", {})
	if not inline_parser then
		return false
	end

	-- Parse syntax tree
	inline_parser:parse()

	-- Define query
	local query_str = [[(latex_block) @latex_block]]
	local ok, query = pcall(ts.query.parse, "markdown_inline", query_str)
	if not ok or not query then
		return false
	end

	-- Get root node
	local root = inline_parser:trees()[1]:root()
	if not root then
		return false
	end

	-- Check captures
	for _, node in query:iter_captures(root, bufnr, row, row + 1) do
		local sr, sc, er, ec = node:range()
		if sr <= row and row <= er then
			local valid_col = (row == sr and col >= sc) or (row == er and col <= ec) or (row > sr and row < er)

			if valid_col then
				return true
			end
		end
	end
	return false
end

return M
