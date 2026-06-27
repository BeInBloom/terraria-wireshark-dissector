local player_id = ProtoField.uint8(
	"terraria.minion_attack_target_update.player_id",
	"Player ID",
	base.DEC
)
local minion_attack_target = ProtoField.int16(
	"terraria.minion_attack_target_update.minion_attack_target",
	"Minion Attack Target",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:int16_le(minion_attack_target)
end

return {
	id = 115,
	build = build,
	fields = {
		player_id,
		minion_attack_target,
	},
}
