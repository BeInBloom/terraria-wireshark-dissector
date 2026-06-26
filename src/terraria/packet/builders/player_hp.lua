local player_id = ProtoField.uint8("terraria.player_hp.player_id", "Player ID", base.DEC)
local hp = ProtoField.int16("terraria.player_hp.hp", "HP", base.DEC)
local max_hp = ProtoField.int16("terraria.player_hp.max_hp", "Max HP", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:int16_le(hp)
	payload:int16_le(max_hp)
end

return {
	id = 16,
	build = build,
	fields = {
		player_id,
		hp,
		max_hp,
	},
}
