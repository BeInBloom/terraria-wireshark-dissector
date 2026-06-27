local player_id = ProtoField.int16(
	"terraria.spawn_boss_invasion.player_id",
	"Player ID",
	base.DEC
)
local invasion_type = ProtoField.int16(
	"terraria.spawn_boss_invasion.invasion_type",
	"Invasion Type",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(player_id)
	payload:int16_le(invasion_type)
end

return {
	id = 61,
	build = build,
	fields = {
		player_id,
		invasion_type,
	},
}
