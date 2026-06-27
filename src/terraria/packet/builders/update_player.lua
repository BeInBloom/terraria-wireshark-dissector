local update_player_reader = require("terraria.packet.readers.update_player_reader")

local fields = {
	root = ProtoField.bytes("terraria.update_player.root", "Update Player"),
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
	position = ProtoField.bytes("terraria.update_player.position", "Position"),
	position_x = ProtoField.float("terraria.update_player.position_x", "Position X"),
	position_y = ProtoField.float("terraria.update_player.position_y", "Position Y"),
	velocity = ProtoField.bytes("terraria.update_player.velocity", "Velocity"),
	velocity_x = ProtoField.float("terraria.update_player.velocity_x", "Velocity X"),
	velocity_y = ProtoField.float("terraria.update_player.velocity_y", "Velocity Y"),
	original_position = ProtoField.bytes(
		"terraria.update_player.original_position",
		"Original Position"
	),
	original_position_x = ProtoField.float(
		"terraria.update_player.original_position_x",
		"Original Position X"
	),
	original_position_y = ProtoField.float(
		"terraria.update_player.original_position_y",
		"Original Position Y"
	),
	home_position = ProtoField.bytes("terraria.update_player.home_position", "Home Position"),
	home_position_x = ProtoField.float(
		"terraria.update_player.home_position_x",
		"Home Position X"
	),
	home_position_y = ProtoField.float(
		"terraria.update_player.home_position_y",
		"Home Position Y"
	),
}

local vectors = {
	position = {
		group_field = fields.position,
		x_field = fields.position_x,
		y_field = fields.position_y,
	},
	velocity = {
		group_field = fields.velocity,
		x_field = fields.velocity_x,
		y_field = fields.velocity_y,
	},
	original_position = {
		group_field = fields.original_position,
		x_field = fields.original_position_x,
		y_field = fields.original_position_y,
	},
	home_position = {
		group_field = fields.home_position,
		x_field = fields.home_position_x,
		y_field = fields.home_position_y,
	},
}

---@param tree TreeItem
---@param fields table
---@param value TerrariaUpdatePlayer
---@return nil
local function add_update_player_base(tree, fields, value)
	tree:add(fields.player_id, value.player_id_range, value.player_id)
	tree:add(fields.control, value.control_range, value.control)
	tree:add(fields.pulley, value.pulley_range, value.pulley)
	tree:add(fields.misc, value.misc_range, value.misc)
	tree:add(fields.sleeping_info, value.sleeping_info_range, value.sleeping_info)
	tree:add(fields.selected_item, value.selected_item_range, value.selected_item)
end

---@param parent TreeItem
---@param spec { group_field: ProtoField, x_field: ProtoField, y_field: ProtoField }
---@param vector TerrariaRangedVector2?
local function add_vector_group(parent, spec, vector)
	if not vector then
		return
	end

	local tree = parent:add(spec.group_field, vector.range)
	tree:add_le(spec.x_field, vector.x_range, vector.x)
	tree:add_le(spec.y_field, vector.y_range, vector.y)
end

---@param payload PayloadReader
local function build(payload)
	local value, range = update_player_reader.new(payload.reader):read()
	local tree = payload.tree:add(fields.root, range)

	add_update_player_base(tree, fields, value)
	add_vector_group(tree, vectors.position, value.position)
	add_vector_group(tree, vectors.velocity, value.velocity)
	add_vector_group(tree, vectors.original_position, value.original_position)
	add_vector_group(tree, vectors.home_position, value.home_position)
end

return {
	id = 13,
	build = build,
	fields = {
		fields.root,
		fields.player_id,
		fields.control,
		fields.pulley,
		fields.misc,
		fields.sleeping_info,
		fields.selected_item,
		fields.position,
		fields.position_x,
		fields.position_y,
		fields.velocity,
		fields.velocity_x,
		fields.velocity_y,
		fields.original_position,
		fields.original_position_x,
		fields.original_position_y,
		fields.home_position,
		fields.home_position_x,
		fields.home_position_y,
	},
}
