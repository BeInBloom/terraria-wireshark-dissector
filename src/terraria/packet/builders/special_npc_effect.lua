local player_id = ProtoField.uint8(
	"terraria.special_npc_effect.player_id",
	"Player ID",
	base.DEC
)
local effect_type = ProtoField.uint8(
	"terraria.special_npc_effect.effect_type",
	"Effect Type",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:uint8(effect_type)
end

return {
	id = 51,
	build = build,
	fields = {
		player_id,
		effect_type,
	},
}
