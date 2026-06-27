local update_item_drop_reader = require("terraria.packet.readers.update_item_drop_reader")

local fields = {
	root = ProtoField.bytes("terraria.update_item_drop.root", "Update Item Drop"),
	item_id = ProtoField.int16("terraria.update_item_drop.item_id", "Item ID", base.DEC),
	position = ProtoField.bytes("terraria.update_item_drop.position", "Position"),
	position_x = ProtoField.float("terraria.update_item_drop.position_x", "Position X"),
	position_y = ProtoField.float("terraria.update_item_drop.position_y", "Position Y"),
	velocity = ProtoField.bytes("terraria.update_item_drop.velocity", "Velocity"),
	velocity_x = ProtoField.float("terraria.update_item_drop.velocity_x", "Velocity X"),
	velocity_y = ProtoField.float("terraria.update_item_drop.velocity_y", "Velocity Y"),
	item = ProtoField.bytes("terraria.update_item_drop.item", "Item"),
	stack_size = ProtoField.int16("terraria.update_item_drop.stack_size", "Stack Size", base.DEC),
	prefix = ProtoField.uint8("terraria.update_item_drop.prefix", "Prefix", base.DEC),
	no_delay = ProtoField.uint8("terraria.update_item_drop.no_delay", "No Delay", base.DEC),
	item_net_id = ProtoField.int16("terraria.update_item_drop.item_net_id", "Item Net ID", base.DEC),
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
}

---@param tree TreeItem
---@param fields table
---@param value TerrariaUpdateItemDrop
---@return nil
local function add_update_item_drop_item(tree, fields, value)
	local item = tree:add(fields.item, value.item_range)

	item:add_le(fields.stack_size, value.stack_size_range, value.stack_size)
	item:add(fields.prefix, value.prefix_range, value.prefix)
	item:add(fields.no_delay, value.no_delay_range, value.no_delay)
	item:add_le(fields.item_net_id, value.item_net_id_range, value.item_net_id)
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
---@return nil
local function build(payload)
	local value, range = update_item_drop_reader.new(payload.reader):read()
	local tree = payload.tree:add(fields.root, range)

	tree:add_le(fields.item_id, value.item_id_range, value.item_id)
	add_vector_group(tree, vectors.position, value.position)
	add_vector_group(tree, vectors.velocity, value.velocity)
	add_update_item_drop_item(tree, fields, value)
end

return {
	id = 21,
	build = build,
	fields = {
		fields.root,
		fields.item_id,
		fields.position,
		fields.position_x,
		fields.position_y,
		fields.velocity,
		fields.velocity_x,
		fields.velocity_y,
		fields.item,
		fields.stack_size,
		fields.prefix,
		fields.no_delay,
		fields.item_net_id,
	},
}
