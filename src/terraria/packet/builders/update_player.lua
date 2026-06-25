local fields = {
	player_id = ProtoField.uint8("terraria.update_player.player_id", "Player ID", base.DEC),
	control = ProtoField.uint8("terraria.update_player.control", "Control", base.HEX),
	pulley = ProtoField.uint8("terraria.update_player.pulley", "Pulley", base.HEX),
	misc = ProtoField.uint8("terraria.update_player.misc", "Misc", base.HEX),
	sleeping_info = ProtoField.uint8(
		"terraria.update_player.sleeping_info",
		"Sleeping Info",
		base.HEX
	),
	selected_item = ProtoField.uint8(
		"terraria.update_player.selected_item",
		"Selected Item",
		base.DEC
	),
	position_x = ProtoField.float("terraria.update_player.position_x", "Position X"),
	position_y = ProtoField.float("terraria.update_player.position_y", "Position Y"),
	velocity_x = ProtoField.float("terraria.update_player.velocity_x", "Velocity X"),
	velocity_y = ProtoField.float("terraria.update_player.velocity_y", "Velocity Y"),
	original_position_x = ProtoField.float(
		"terraria.update_player.original_position_x",
		"Original Position X"
	),
	original_position_y = ProtoField.float(
		"terraria.update_player.original_position_y",
		"Original Position Y"
	),
	home_position_x = ProtoField.float(
		"terraria.update_player.home_position_x",
		"Home Position X"
	),
	home_position_y = ProtoField.float(
		"terraria.update_player.home_position_y",
		"Home Position Y"
	),
}

---@param payload PayloadReader
local function build(payload)
	payload:update_player(fields)
end

return {
	id = 13,
	build = build,
	fields = {
		fields.player_id,
		fields.control,
		fields.pulley,
		fields.misc,
		fields.sleeping_info,
		fields.selected_item,
		fields.position_x,
		fields.position_y,
		fields.velocity_x,
		fields.velocity_y,
		fields.original_position_x,
		fields.original_position_y,
		fields.home_position_x,
		fields.home_position_y,
	},
}
