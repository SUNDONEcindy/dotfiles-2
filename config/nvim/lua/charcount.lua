-- Character counting utilities

local M = {}

-- Count characters in current markdown section
function M.count_markdown_section()
	local has_ts_parsers, parsers = pcall(require, "nvim-treesitter.parsers")
	if not has_ts_parsers then
		vim.notify("Treesitter not available", vim.log.levels.ERROR)
		return
	end

	-- Get the parser for markdown (block structure, not inline)
	local parser = parsers.get_parser(0, "markdown")
	if not parser then
		vim.notify("Markdown parser not available", vim.log.levels.ERROR)
		return
	end

	-- Get the syntax tree
	local tree = parser:parse()[1]
	local root = tree:root()

	-- Get cursor position
	local cursor = vim.api.nvim_win_get_cursor(0)
	local cursor_row = cursor[1] - 1 -- Convert to 0-indexed

	-- Find the section containing the cursor
	local section_node = nil
	for child in root:iter_children() do
		local start_row, _, end_row, _ = child:range()
		if child:type() == "section" and start_row <= cursor_row and cursor_row <= end_row then
			section_node = child
			break
		end
	end

	-- If no section found, use entire document
	if not section_node then
		section_node = root
	end

	-- Get the range of the section
	local start_row, start_col, end_row, end_col = section_node:range()

	-- Get the actual text content
	local text = vim.treesitter.get_node_text(section_node, 0)
	local char_count = #text

	vim.notify(string.format("Section: %d characters (%d lines)", char_count, end_row - start_row + 1), vim.log.levels.INFO)
end

return M
