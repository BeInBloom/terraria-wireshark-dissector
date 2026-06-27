local x = ProtoField.int16("terraria.food_platter_try_placing.x", "X", base.DEC)
local y = ProtoField.int16("terraria.food_platter_try_placing.y", "Y", base.DEC)
local item_id = ProtoField.int16("terraria.food_platter_try_placing.item_id", "Item ID", base.DEC)
local prefix = ProtoField.uint8("terraria.food_platter_try_placing.prefix", "Prefix", base.DEC)
local stack = ProtoField.int16("terraria.food_platter_try_placing.stack", "Stack", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(x)
	payload:int16_le(y)
	payload:int16_le(item_id)
	payload:uint8(prefix)
	payload:int16_le(stack)
end

return {
	id = 133,
	build = build,
	fields = {
		x,
		y,
		item_id,
		prefix,
		stack,
	},
}
