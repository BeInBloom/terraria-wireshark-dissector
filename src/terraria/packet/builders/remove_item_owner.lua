local item_index = ProtoField.int16("terraria.remove_item_owner.item_index", "Item Index", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(item_index)
end

return {
	id = 39,
	build = build,
	fields = {
		item_index,
	},
}
