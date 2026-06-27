local player_id = ProtoField.uint8(
	"terraria.player_teleport_portal.player_id",
	"Player ID",
	base.DEC
)
local portal_color_index = ProtoField.int16(
	"terraria.player_teleport_portal.portal_color_index",
	"Portal Color Index",
	base.DEC
)
local new_position_x = ProtoField.float(
	"terraria.player_teleport_portal.new_position_x",
	"New Position X"
)
local new_position_y = ProtoField.float(
	"terraria.player_teleport_portal.new_position_y",
	"New Position Y"
)
local velocity_x = ProtoField.float(
	"terraria.player_teleport_portal.velocity_x",
	"Velocity X"
)
local velocity_y = ProtoField.float(
	"terraria.player_teleport_portal.velocity_y",
	"Velocity Y"
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:int16_le(portal_color_index)
	payload:single_le(new_position_x)
	payload:single_le(new_position_y)
	payload:single_le(velocity_x)
	payload:single_le(velocity_y)
end

return {
	id = 96,
	build = build,
	fields = {
		player_id,
		portal_color_index,
		new_position_x,
		new_position_y,
		velocity_x,
		velocity_y,
	},
}
