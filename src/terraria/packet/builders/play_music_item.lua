local player_id = ProtoField.uint8(
	"terraria.play_music_item.player_id",
	"Player ID",
	base.DEC
)
local note = ProtoField.float("terraria.play_music_item.note", "Note")

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:single_le(note)
end

return {
	id = 58,
	build = build,
	fields = {
		player_id,
		note,
	},
}
