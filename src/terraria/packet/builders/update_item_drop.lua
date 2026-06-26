local item_id = ProtoField.int16("terraria.update_item_drop.item_id", "Item ID", base.DEC)
local position_x = ProtoField.float("terraria.update_item_drop.position_x", "Position X")
local position_y = ProtoField.float("terraria.update_item_drop.position_y", "Position Y")
local velocity_x = ProtoField.float("terraria.update_item_drop.velocity_x", "Velocity X")
local velocity_y = ProtoField.float("terraria.update_item_drop.velocity_y", "Velocity Y")
local stack_size = ProtoField.int16("terraria.update_item_drop.stack_size", "Stack Size", base.DEC)
local prefix = ProtoField.uint8("terraria.update_item_drop.prefix", "Prefix", base.DEC)
local no_delay = ProtoField.uint8("terraria.update_item_drop.no_delay", "No Delay", base.DEC)
local item_net_id = ProtoField.int16("terraria.update_item_drop.item_net_id", "Item Net ID", base.DEC)

local function build_movement(payload)
	payload:single_le(position_x)
	payload:single_le(position_y)
	payload:single_le(velocity_x)
	payload:single_le(velocity_y)
end

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(item_id)
	build_movement(payload)
	payload:int16_le(stack_size)
	payload:uint8(prefix)
	payload:uint8(no_delay)
	payload:int16_le(item_net_id)
end

return {
	id = 21,
	build = build,
	fields = {
		item_id,
		position_x,
		position_y,
		velocity_x,
		velocity_y,
		stack_size,
		prefix,
		no_delay,
		item_net_id,
	},
}
