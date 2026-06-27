local player_id = ProtoField.uint8("terraria.nebula_level_up.player_id", "Player ID", base.DEC)
local level_up_type = ProtoField.uint16(
	"terraria.nebula_level_up.level_up_type",
	"Level Up Type",
	base.DEC
)
local origin_x = ProtoField.float("terraria.nebula_level_up.origin_x", "Origin X")
local origin_y = ProtoField.float("terraria.nebula_level_up.origin_y", "Origin Y")

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:uint16_le(level_up_type)
	payload:single_le(origin_x)
	payload:single_le(origin_y)
end

return {
	id = 102,
	build = build,
	fields = {
		player_id,
		level_up_type,
		origin_x,
		origin_y,
	},
}
