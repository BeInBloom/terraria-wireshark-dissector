local player_index = ProtoField.uint8(
	"terraria.emoji.player_index",
	"Player Index",
	base.DEC
)
local emoticon_id = ProtoField.uint8(
	"terraria.emoji.emoticon_id",
	"Emoticon ID",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_index)
	payload:uint8(emoticon_id)
end

return {
	id = 120,
	build = build,
	fields = {
		player_index,
		emoticon_id,
	},
}
