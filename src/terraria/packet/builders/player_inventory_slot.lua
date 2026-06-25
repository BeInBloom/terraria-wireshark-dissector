local player_id = ProtoField.uint8(
	"terraria.player_inventory_slot.player_id",
	"Player ID",
	base.DEC
)
local slot_id = ProtoField.int16(
	"terraria.player_inventory_slot.slot_id",
	"Slot ID",
	base.DEC
)
local stack = ProtoField.int16(
	"terraria.player_inventory_slot.stack",
	"Stack",
	base.DEC
)
local prefix = ProtoField.uint8(
	"terraria.player_inventory_slot.prefix",
	"Prefix",
	base.DEC
)
local item_net_id = ProtoField.int16(
	"terraria.player_inventory_slot.item_net_id",
	"Item Net ID",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:int16_le(slot_id)
	payload:int16_le(stack)
	payload:uint8(prefix)
	payload:int16_le(item_net_id)
end

return {
	id = 5,
	build = build,
	fields = {
		player_id,
		slot_id,
		stack,
		prefix,
		item_net_id,
	},
}
