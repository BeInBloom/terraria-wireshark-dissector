local x = ProtoField.int16("terraria.place_item_frame.x", "X", base.DEC)
local y = ProtoField.int16("terraria.place_item_frame.y", "Y", base.DEC)
local item_id = ProtoField.int16("terraria.place_item_frame.item_id", "Item ID", base.DEC)
local prefix = ProtoField.uint8("terraria.place_item_frame.prefix", "Prefix", base.DEC)
local stack = ProtoField.int16("terraria.place_item_frame.stack", "Stack", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(x)
	payload:int16_le(y)
	payload:int16_le(item_id)
	payload:uint8(prefix)
	payload:int16_le(stack)
end

return {
	id = 89,
	build = build,
	fields = {
		x,
		y,
		item_id,
		prefix,
		stack,
	},
}
