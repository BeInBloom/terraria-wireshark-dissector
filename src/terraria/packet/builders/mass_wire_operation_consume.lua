local item_type = ProtoField.int16("terraria.mass_wire_operation_consume.item_type", "Item Type", base.DEC)
local quantity = ProtoField.int16("terraria.mass_wire_operation_consume.quantity", "Quantity", base.DEC)
local player_id = ProtoField.uint8(
	"terraria.mass_wire_operation_consume.player_id",
	"Player ID",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(item_type)
	payload:int16_le(quantity)
	payload:uint8(player_id)
end

return {
	id = 110,
	build = build,
	fields = {
		item_type,
		quantity,
		player_id,
	},
}
