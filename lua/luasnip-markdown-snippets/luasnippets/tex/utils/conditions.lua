local ts = vim.treesitter

local M = {}

local function in_text_block()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row, col = unpack(cursor)
	row = row - 1

	local lines = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)
	if not lines or #lines == 0 then
		return false
	end

	local line = lines[1]
	local cursor_col = col + 1

	local search_start = 1
	while true do
		local text_start, text_start_end = line:find("\\text{", search_start, true)
		if not text_start then
			break
		end
		local text_end = line:find("}", text_start_end + 1, true)

		if text_end and cursor_col > text_start_end and cursor_col <= text_end then
			return true
		end

		search_start = text_start_end + 1
	end

	return false
end

function M.in_math()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row, col = unpack(cursor)
	row = row - 1

	local inline_parser = ts.get_parser(bufnr, "markdown_inline", {})
	if not inline_parser then
		return false
	end

	inline_parser:parse()

	local query_str = [[(latex_block) @latex_block]]
	local ok, query = pcall(ts.query.parse, "markdown_inline", query_str)
	if not ok or not query then
		return false
	end

	local root = inline_parser:trees()[1]:root()
	if not root then
		return false
	end

	for _, node in query:iter_captures(root, bufnr, row, row + 1) do
		local sr, sc, er, ec = node:range()
		if sr <= row and row <= er then
			local valid_col = (row == sr and col >= sc) or (row == er and col <= ec) or (row > sr and row < er)

			if valid_col then
				if in_text_block() then
					return false
				end
				return true
			end
		end
	end
	return false
end

return M
