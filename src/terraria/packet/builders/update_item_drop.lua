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

---@param payload PayloadReader
local function build(payload)
	payload:update_item_drop(fields)
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
