local player_id = ProtoField.uint8("terraria.heal_effect.player_id", "Player ID", base.DEC)
local heal_amount = ProtoField.int16("terraria.heal_effect.heal_amount", "Heal Amount", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:int16_le(heal_amount)
end

return {
	id = 35,
	build = build,
	fields = {
		player_id,
		heal_amount,
	},
}
