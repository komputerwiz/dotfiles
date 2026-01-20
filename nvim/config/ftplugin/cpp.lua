local function switch_to_extension(target_exts)
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname == '' then
		vim.notify('No file name', vim.log.levels.WARN)
		return
	end

	local base = bufname:gsub('%.[^.]+$', '')
	for _, ext in ipairs(target_exts) do
		local candidate = base .. ext
		if vim.fs.exists(candidate) then
			vim.cmd.edit(candidate)
			return
		end
	end

	vim.notify('No corresponding file found', vim.log.levels.INFO)
end

local function goto_header()
	switch_to_extension({ '.h', '.hpp' })
end

local function goto_source()
	switch_to_extension({ '.cpp', '.cc', '.cxx' })
end

local function goto_template_impl()
	switch_to_extension({ '.ipp', '.tpp', '.inl' })
end

vim.keymap.set('n', '<LocalLeader>gh', goto_header, { buffer = true, desc = 'Go to C++ header' })
vim.keymap.set('n', '<LocalLeader>gc', goto_source, { buffer = true, desc = 'Go to C++ impl/source' })
vim.keymap.set('n', '<LocalLeader>gi', goto_template_impl, { buffer = true, desc = 'Go to C++ template impl' })
