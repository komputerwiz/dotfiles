local ls = require('luasnip')
local u = require('snippets.util')

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local emoji_hidden = false

-- generates a new random v4 UUID
local function uuid4()
	local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
	return template:gsub('[xy]', function(ch)
		local v = (ch == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
		return string.format('%x', v)
	end)
end

local M = {
	s(
		{ trig = 'date', name = 'ISO 8601 Date' },
		f(function()
			return os.date('%F')
		end)
	),

	s(
		{ trig = 'time', name = 'ISO 8601 Time' },
		f(function()
			return os.date('%T')
		end)
	),

	s(
		{ trig = 'timetz', name = 'ISO 8601 Time with Timezone Offset' },
		f(function()
			return os.date('%T%z')
		end)
	),

	s(
		{ trig = 'datetime', name = 'ISO 8601 Date and Time' },
		f(function()
			return os.date('%F %T')
		end)
	),

	s(
		{ trig = 'datetimetz', name = 'ISO 8601 Date and Time with Timezone Offset' },
		f(function()
			return os.date('%F %T%z')
		end)
	),

	s('shrug', t('¯\\_(ツ)_/¯')),
	s({ trig = 'uuid', name = 'Random UUIDv4' }, f(uuid4)),
}

-- favorite emoji

local function emoji(glyph, triggers)
	for _, name in ipairs(triggers) do
		table.insert(M, s({ hidden = emoji_hidden, trig = ':' .. name .. ':', desc = glyph }, t(glyph)))
	end
end

emoji('👍', {'thumbsup', '+1'})
emoji('👎', {'thumbsdown', '-1'})

emoji('🙁', {'sad', 'frown', 'slightly_frowning_face'})
emoji('🙂', {'happy', 'smile', 'slightly_smiling_face'})
emoji('🙃', {'upside_down', 'upside_down_face'})
emoji('😁', {'grin'})
emoji('😂', {'joy'})
emoji('😅', {'sweat_smile'})
emoji('😆', {'laugh'})
emoji('😉', {'wink'})
emoji('😋', {'yum'})
emoji('😎', {'sunglasses'})
emoji('😏', {'smirk'})
emoji('😒', {'unamused'})
emoji('😓', {'sweat'})
emoji('😕', {'confused'})
emoji('😖', {'confounded'})
emoji('😜', {'tongue_wink', 'stuck_out_tongue_winking_eye'})
emoji('😝', {'tongue'})
emoji('😞', {'disappointed'})
emoji('😢', {'cry'})
emoji('😬', {'grimace'})
emoji('😭', {'sob'})
emoji('🙄', {'eyeroll', 'rolling_eyes'})
emoji('🤔', {'thinking'})
emoji('🤣', {'rofl', 'rolling_on_the_floor_laughing'})
emoji('🧐', {'monacle'})
emoji('🫪', {'distorted_face'})

emoji('🤦‍♂️', {'facepalm'})

emoji('🐬', {'dolphin'})
emoji('🫍', {'orca'})
emoji('🐳', {'whale'})
emoji('🐋', {'whale2'})
emoji('🐾', {'paws', 'paw_prints', 'pawprints'})

emoji('✅', {'check', 'checkmark', 'checkbox'})
emoji('❤️', {'heart'})
emoji('🍺', {'beer'})
emoji('🍻', {'beers', 'cheers'})
emoji('🎁', {'gift'})
emoji('🎂', {'cake'})
emoji('🎈', {'balloon'})
emoji('🎉', {'tada', 'party_popper'})
emoji('🎊', {'confetti'})
emoji('👀', {'eyes'})
emoji('💥', {'boom'})
emoji('💨', {'poof', 'zip', 'zoom'})
emoji('💩', {'poop'})
emoji('💯', {'100'})
emoji('📦', {'box', 'package'})
emoji('🔥', {'fire'})
emoji('🚀', {'rocket'})
emoji('🧭', {'compass'})
emoji('🧵', {'thread'})

emoji('🇺🇸', {'us_flag', 'usa'})

return M
