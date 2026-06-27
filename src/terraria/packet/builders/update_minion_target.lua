local player_id = ProtoField.uint8(
	"terraria.update_minion_target.player_id",
	"Player ID",
	base.DEC
)
local target_x = ProtoField.float("terraria.update_minion_target.target_x", "Target X")
local target_y = ProtoField.float("terraria.update_minion_target.target_y", "Target Y")

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:single_le(target_x)
	payload:single_le(target_y)
end

return {
	id = 99,
	build = build,
	fields = {
		player_id,
		target_x,
		target_y,
	},
}
