local player_id = ProtoField.uint8(
	"terraria.spawn_player.player_id",
	"Player ID",
	base.DEC
)
local spawn_position = ProtoField.bytes("terraria.spawn_player.position", "Spawn Position")
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
local spawn_state = ProtoField.bytes("terraria.spawn_player.state", "Spawn State")
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
local function build_spawn_state(payload)
	payload:int32_le(respawn_time)
	payload:uint8(spawn_context)
end

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:int16_pair(spawn_position, spawn_x, spawn_y)
	payload:group(spawn_state, "Spawn State", build_spawn_state)
end

return {
	id = 12,
	build = build,
	fields = {
		player_id,
		spawn_position,
		spawn_x,
		spawn_y,
		spawn_state,
		respawn_time,
		spawn_context,
	},
}
