-- Format JSON using jq
-- Supports: current line, visual selection, or entire buffer
local function jq_format(start_line, end_line)
	-- Abort early if jq is unavailable
	if vim.fn.executable('jq') ~= 1 then
		vim.notify('jq not found in PATH', vim.log.levels.WARN)
		return
	end

	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

	if #lines == 0 then
		return
	end

	local input = table.concat(lines, '\n')
	local output = vim.fn.system({ 'jq', '.' }, input)

	if vim.v.shell_error ~= 0 then
		vim.notify('jq error:\n' .. output, vim.log.levels.ERROR)
		return
	end

	local formatted = vim.split(output, '\n', { plain = true })

	-- jq usually appends a trailing newline
	if formatted[#formatted] == '' then
		table.remove(formatted)
	end

	vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, formatted)
end

-- Current line
vim.keymap.set('n', '<LocalLeader>jq', function()
	local line = vim.fn.line('.')
	jq_format(line, line)
end, { buffer = true, desc = "jq format line" })

-- Visual selection
vim.keymap.set('v', '<LocalLeader>jq', function()
	jq_format(vim.fn.line("'<"), vim.fn.line("'>"))
end, { buffer = true, desc = 'jq format selection' })

-- Entire buffer
vim.keymap.set('n', '<LocalLeader>jQ', function()
	jq_format(1, vim.fn.line('$'))
end, { buffer = true, desc = 'jq format buffer' })
