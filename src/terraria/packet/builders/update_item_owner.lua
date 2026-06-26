local item_id = ProtoField.int16("terraria.update_item_owner.item_id", "Item ID", base.DEC)
local player_id = ProtoField.uint8("terraria.update_item_owner.player_id", "Player ID", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(item_id)
	payload:uint8(player_id)
end

return {
	id = 22,
	build = build,
	fields = {
		item_id,
		player_id,
	},
}
