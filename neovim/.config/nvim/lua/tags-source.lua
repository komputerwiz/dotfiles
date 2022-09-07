-- based on https://github.com/jose-elias-alvarez/null-ls.nvim/blob/1569ad4817492e0daefa4e1bcf55f8280cdc82db/lua/null-ls/builtins/completion/tags.lua
-- modified here to remove the hard-coded "minimum completion word length" of 4

local null_ls = require('null-ls')

local function tbl_uniq(t)
	local new_table = {}
	local hash = {}
	for _, v in pairs(t) do
		if not hash[v] then
			table.insert(new_table, v)
			hash[v] = true
		end
	end

	return new_table
end

local tags_source = {
	name = 'tags',
	meta = {
		description = 'Tags completion source.',
	},
	method = null_ls.methods.COMPLETION,
	filetypes = {},
	generator_opts = {
		runtime_condition = function(_)
			return #vim.fn.tagfiles() > 0
		end,
	},
	generator = {
		async = true,
		fn = function(params, done)
			-- Tags look up can be expensive
			-- if #params.word_to_complete < 4 then
			-- 	done({ { items = {}, isIncomplete = false } })
			-- 	return
			-- end

			local tags = vim.fn.taglist(params.word_to_complete)
			if tags == 0 then
				done({ { items = {}, isIncomplete = false } })
				return
			end

			local words = {}
			local items = {}
			for _, tag in ipairs(tags) do
				table.insert(words, tag.name)
			end

			words = tbl_uniq(words)
			for _, word in ipairs(words) do
				table.insert(items, {
					label = word,
					insertText = word,
				})
			end

			done({ { items = items, isIncomplete = #items == 0 } })
		end,
	},
}

return tags_source
