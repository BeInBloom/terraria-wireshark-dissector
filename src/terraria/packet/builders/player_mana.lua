local player_id = ProtoField.uint8(
	"terraria.player_mana.player_id",
	"Player ID",
	base.DEC
)
local mana = ProtoField.int16("terraria.player_mana.mana", "Mana", base.DEC)
local max_mana = ProtoField.int16("terraria.player_mana.max_mana", "Max Mana", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:int16_le(mana)
	payload:int16_le(max_mana)
end

return {
	id = 42,
	build = build,
	fields = {
		player_id,
		mana,
		max_mana,
	},
}
