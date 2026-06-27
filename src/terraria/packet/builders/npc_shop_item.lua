local slot = ProtoField.uint8("terraria.npc_shop_item.slot", "Slot", base.DEC)
local item_type = ProtoField.int16("terraria.npc_shop_item.item_type", "Item Type", base.DEC)
local stack = ProtoField.int16("terraria.npc_shop_item.stack", "Stack", base.DEC)
local prefix = ProtoField.uint8("terraria.npc_shop_item.prefix", "Prefix", base.DEC)
local value = ProtoField.int32("terraria.npc_shop_item.value", "Value", base.DEC)
local flags = ProtoField.uint8("terraria.npc_shop_item.flags", "Flags", base.HEX)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(slot)
	payload:int16_le(item_type)
	payload:int16_le(stack)
	payload:uint8(prefix)
	payload:int32_le(value)
	payload:uint8(flags)
end

return {
	id = 104,
	build = build,
	fields = {
		slot,
		item_type,
		stack,
		prefix,
		value,
		flags,
	},
}
