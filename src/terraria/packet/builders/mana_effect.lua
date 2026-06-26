local player_id = ProtoField.uint8(
	"terraria.mana_effect.player_id",
	"Player ID",
	base.DEC
)
local mana_amount = ProtoField.int16(
	"terraria.mana_effect.mana_amount",
	"Mana Amount",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:int16_le(mana_amount)
end

return {
	id = 43,
	build = build,
	fields = {
		player_id,
		mana_amount,
	},
}
