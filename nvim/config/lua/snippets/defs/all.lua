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

-- generates a new random v4 UUID
local function uuid4()
	local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
	return template:gsub('[xy]', function(ch)
		local v = (ch == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
		return string.format('%x', v)
	end)
end

return {
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

	-- favorite emoji
	s({ hidden = true, trig = ':thumbsup:', desc = '👍' }, t('👍')),
	s({ hidden = true, trig = ':+1:', desc = '👍' }, t('👍')),
	s({ hidden = true, trig = ':happy:', desc = '🙂'}, t('🙂')),
	s({ hidden = true, trig = ':smile:', desc = '🙂'}, t('🙂')),
	s({ hidden = true, trig = ':sad:', desc = '🙁'}, t('🙁')),
	s({ hidden = true, trig = ':frown:', desc = '🙁'}, t('🙁')),
	s({ hidden = true, trig = ':grin:', desc = '😁'}, t('😁')),
	s({ hidden = true, trig = ':wink:', desc = '😉'}, t('😉')),
	s({ hidden = true, trig = ':sweat_smile:', desc = '😅' }, t('😅')),
	s({ hidden = true, trig = ':joy:', desc = '😂' }, t('😂')),
	s({ hidden = true, trig = ':sunglasses:', desc = '😎' }, t('😎')),
	s({ hidden = true, trig = ':smirk:', desc = '😏' }, t('😏')),
	s({ hidden = true, trig = ':unamused:', desc = '😒' }, t('😒')),
	s({ hidden = true, trig = ':sweat:', desc = '😓' }, t('😓')),
	s({ hidden = true, trig = ':confused:', desc = '😕' }, t('😕')),
	s({ hidden = true, trig = ':confounded:', desc = '😖' }, t('😖')),
	s({ hidden = true, trig = ':tongue_wink:', desc = '😜' }, t('😜')),
	s({ hidden = true, trig = ':tongue:', desc = '😝' }, t('😝')),
	s({ hidden = true, trig = ':disappointed:', desc = '😞' }, t('😞')),
	s({ hidden = true, trig = ':cry:', desc = '😢' }, t('😢')),
	s({ hidden = true, trig = ':grimace:', desc = '😬' }, t('😬')),
	s({ hidden = true, trig = ':sob:', desc = '😭' }, t('😭')),
	s({ hidden = true, trig = ':dolphin:', desc = '🐬' }, t('🐬')),
	s({ hidden = true, trig = ':orca:', desc = '🫍' }, t('🫍')),
	s({ hidden = true, trig = ':whale:', desc = '🐳' }, t('🐳')),
	s({ hidden = true, trig = ':whale2:', desc = '🐋' }, t('🐋')),
	s({ hidden = true, trig = ':paws:', desc = '🐾' }, t('🐾')),
	s({ hidden = true, trig = ':paw_prints:', desc = '🐾' }, t('🐾')),
	s({ hidden = true, trig = ':pawprints:', desc = '🐾' }, t('🐾')),
	s({ hidden = true, trig = ':rocket:', desc = '🚀' }, t('🚀')),
	s({ hidden = true, trig = ':thinking:', desc = '🤔' }, t('🤔')),
	s({ hidden = true, trig = ':fire:', desc = '🔥' }, t('🔥')),
	s({ hidden = true, trig = ':box:', desc = '📦' }, t('📦')),
	s({ hidden = true, trig = ':100:', desc = '💯' }, t('💯')),
	s({ hidden = true, trig = ':poop:', desc = '💩' }, t('💩')),
	s({ hidden = true, trig = ':boom:', desc = '💥' }, t('💥')),
	s({ hidden = true, trig = ':heart:', desc = '❤' }, t('❤')),
	s({ hidden = true, trig = ':eyes:', desc = '👀' }, t('👀')),
	s({ hidden = true, trig = ':gift:', desc = '🎁' }, t('🎁')),
	s({ hidden = true, trig = ':balloon:', desc = '🎈' }, t('🎈')),
	s({ hidden = true, trig = ':tada:', desc = '🎉' }, t('🎉')),
	s({ hidden = true, trig = ':confetti:', desc = '🎊' }, t('🎊')),
	s({ hidden = true, trig = ':beer:', desc = '🍺' }, t('🍺')),
	s({ hidden = true, trig = ':beers:', desc = '🍻' }, t('🍻')),
	s({ hidden = true, trig = ':cheers:', desc = '🍻' }, t('🍻')),
}
