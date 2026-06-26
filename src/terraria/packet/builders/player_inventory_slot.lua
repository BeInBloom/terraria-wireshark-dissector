local slot = ProtoField.bytes("terraria.player_inventory_slot.slot", "Slot")
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
local item = ProtoField.bytes("terraria.player_inventory_slot.item", "Item")
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
local function build_slot(payload)
	payload:uint8(player_id)
	payload:int16_le(slot_id)
end

---@param payload PayloadReader
local function build_item(payload)
	payload:int16_le(stack)
	payload:uint8(prefix)
	payload:int16_le(item_net_id)
end

---@param payload PayloadReader
local function build(payload)
	payload:group(slot, "Slot", build_slot)
	payload:group(item, "Item", build_item)
end

return {
	id = 5,
	build = build,
	fields = {
		slot,
		player_id,
		slot_id,
		item,
		stack,
		prefix,
		item_net_id,
	},
}
