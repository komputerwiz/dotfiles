return {
	{
		'hedyhli/outline.nvim',
		cmd = { 'Outline', 'OutlineOpen' },
		keys = {
			{ '<Leader>o', '<Cmd>Outline<CR>', desc = 'Toggle outline' },
		},
		opts = {
			preview_window = {
				auto_preview = false
			},
			symbols = {
				icons = {
					Array = { icon = "@" },
					Boolean = { icon = "!" },
					Class = { icon = "Ϲ" },
					Constant = { icon = "π" },
					Constructor = { icon = "¢" },
					Enum = { icon = "Ε" },
					EnumMember = { icon = "·" },
					Event = { icon = "&" },
					Field = { icon = "-" },
					File = { icon = "file" },
					Function = { icon = "ƒ" },
					Interface = { icon = "Ι" },
					Key = { icon = "κ" },
					Method = { icon = "µ" },
					Module = { icon = "mod" },
					Namespace = { icon = "∷" },
					Null = { icon = "∅" },
					Number = { icon = "#" },
					Object = { icon = "⊙" },
					Operator = { icon = "⊕" },
					Package = { icon = "pkg" },
					Property = { icon = "+" },
					String = { icon = "$" },
					Struct = { icon = "§" },
					TypeParameter = { icon = "Τ" },
					Variable = { icon = "ν" },
				},
			},
		},
	},
}
