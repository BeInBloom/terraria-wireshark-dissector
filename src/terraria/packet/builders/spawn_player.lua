local player_id = ProtoField.uint8(
	"terraria.spawn_player.player_id",
	"Player ID",
	base.DEC
)
local spawn_x = ProtoField.int16(
	"terraria.spawn_player.spawn_x",
	"Spawn X",
	base.DEC
)
local spawn_y = ProtoField.int16(
	"terraria.spawn_player.spawn_y",
	"Spawn Y",
	base.DEC
)
local respawn_time = ProtoField.int32(
	"terraria.spawn_player.respawn_time",
	"Respawn Time Remaining",
	base.DEC
)
local spawn_context = ProtoField.uint8(
	"terraria.spawn_player.context",
	"Player Spawn Context",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:int16_le(spawn_x)
	payload:int16_le(spawn_y)
	payload:int32_le(respawn_time)
	payload:uint8(spawn_context)
end

return {
	id = 12,
	build = build,
	fields = {
		player_id,
		spawn_x,
		spawn_y,
		respawn_time,
		spawn_context,
	},
}
